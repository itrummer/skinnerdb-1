package operators;

import buffer.BufferManager;
import catalog.CatalogManager;
import config.GeneralConfig;
import config.ParallelConfig;
import expressions.ExpressionInfo;
import expressions.compilation.EvaluatorType;
import expressions.compilation.ExpressionCompiler;
import expressions.compilation.ExpressionInterpreter;
import expressions.compilation.UnaryBoolEval;
import net.sf.jsqlparser.expression.Expression;
import org.eclipse.collections.api.list.primitive.IntList;
import org.eclipse.collections.api.list.primitive.MutableIntList;
import org.eclipse.collections.impl.factory.primitive.IntLists;
import org.eclipse.collections.impl.stream.PrimitiveStreams;
import query.ColumnRef;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Filters a table by applying a unary predicate.
 *
 * @author immanueltrummer
 */
public class Filter {
    /**
     * Load required columns for predicate evaluations into main memory.
     *
     * @param unaryPred     unary predicate
     * @param columnMapping maps query to database columns
     * @throws Exception
     */
    public static void loadPredCols(ExpressionInfo unaryPred,
                                    Map<ColumnRef, ColumnRef> columnMapping)
            throws Exception {
        // Load required data into memory
        if (!GeneralConfig.inMemory) {
            for (ColumnRef queryRef : unaryPred.columnsMentioned) {
                ColumnRef dbRef = columnMapping.get(queryRef);
                BufferManager.loadColumn(dbRef);
            }
        }
    }

    /**
     * Compiles evaluator for unary predicate.
     *
     * @param unaryPred     predicate to compile
     * @param columnMapping maps query to database columns
     * @return compiled predicate evaluator
     * @throws Exception
     */
    public static UnaryBoolEval compilePred(
            ExpressionInfo unaryPred,
            Expression expr,
            Map<ColumnRef, ColumnRef> columnMapping) throws Exception {
        ExpressionCompiler unaryCompiler = new ExpressionCompiler(
                unaryPred, columnMapping, null, null,
                EvaluatorType.UNARY_BOOLEAN);
        expr.accept(unaryCompiler);
        return (UnaryBoolEval) unaryCompiler.getBoolEval();
    }

    public static UnaryBoolEval interpretPred(
            ExpressionInfo unaryPred,
            Expression expr,
            Map<ColumnRef, ColumnRef> columnMapping) {
        ExpressionInterpreter unaryEval = new ExpressionInterpreter(unaryPred,
                columnMapping, null, expr);
        return unaryEval;
    }

    /**
     * Returns list of indices of rows satisfying given
     * unary predicate.s
     *
     * @param unaryPred     unary predicate
     * @param tableName     name of DB table to which predicate applies
     * @param columnMapping maps query columns to buffered columns -
     *                      assume identity mapping if null is specified.
     * @return list of satisfying row indices
     */
    public static IntList executeToList(
            ExpressionInfo unaryPred,
            String tableName,
            Map<ColumnRef, ColumnRef> columnMapping)
            throws Exception {
        // Load required columns for predicate evaluation
        loadPredCols(unaryPred, columnMapping);
        // Compile unary predicate for fast evaluation
        UnaryBoolEval unaryBoolEval = compilePred(unaryPred,
                unaryPred.finalExpression, columnMapping);
        // Get cardinality of table referenced in predicate
        int cardinality = CatalogManager.getCardinality(tableName);
        // Initialize filter result
        IntList result = null;
        // Choose between sequential and parallel processing
        if (true || cardinality <= ParallelConfig.PRE_BATCH_SIZE) {
            RowRange allTuples = new RowRange(0, cardinality - 1);
            result = filterBatch(unaryBoolEval, allTuples);
        } else {
            // Divide tuples into batches
            List<RowRange> batches = split(cardinality);
            // Process batches in parallel
            result = PrimitiveStreams.iIntList(batches.parallelStream()
                    .flatMapToInt(batch ->
                            filterBatch(unaryBoolEval, batch).primitiveStream())
            );
        }

        // Clean up columns loaded for this operation
		/*
		if (!GeneralConfig.inMemory) {
			for (ColumnRef colRef : unaryPred.columnsMentioned) {
				BufferManager.unloadColumn(colRef);
			}
		}
		*/
        return result;
    }

    /**
     * Splits table with given cardinality into tuple batches
     * according to the configuration for parallel processing.
     *
     * @param cardinality cardinality of table to split
     * @return list of row ranges (batches)
     */
    static List<RowRange> split(int cardinality) {
        List<RowRange> batches = new ArrayList<RowRange>();
        for (int batchCtr = 0; batchCtr * ParallelConfig.PRE_BATCH_SIZE
                < cardinality; ++batchCtr) {
            int startIdx = batchCtr * ParallelConfig.PRE_BATCH_SIZE;
            int tentativeEndIdx = startIdx + ParallelConfig.PRE_BATCH_SIZE - 1;
            int endIdx = Math.min(cardinality - 1, tentativeEndIdx);
            RowRange rowRange = new RowRange(startIdx, endIdx);
            batches.add(rowRange);
        }
        return batches;
    }

    /**
     * Filters given tuple batch using specified predicate evaluator,
     * return indices of rows within the batch that satisfy the
     * predicate.
     *
     * @param unaryBoolEval unary predicate evaluator
     * @param rowRange      range of tuple indices of batch
     * @return list of indices satisfying the predicate
     */
    static IntList filterBatch(UnaryBoolEval unaryBoolEval,
                               RowRange rowRange) {
        MutableIntList result = IntLists.mutable.empty();
        // Evaluate predicate for each table row
        for (int rowCtr = rowRange.firstTuple;
             rowCtr <= rowRange.lastTuple; ++rowCtr) {
            if (unaryBoolEval.evaluate(rowCtr) > 0) {
                result.add(rowCtr);
            }
        }
        return result;
    }
}
