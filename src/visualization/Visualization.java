package visualization;

import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.SingleGraph;
import org.graphstream.ui.layout.LayoutRunner;
import org.graphstream.ui.spriteManager.Sprite;
import org.graphstream.ui.spriteManager.SpriteManager;
import org.graphstream.ui.swingViewer.ViewPanel;
import org.graphstream.ui.view.View;
import org.graphstream.ui.view.Viewer;
import query.QueryInfo;

import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.logging.Logger;

public class Visualization implements MouseListener {
    SingleGraph graph;
    Viewer viewer;
    SpriteManager spriteManager;
    TreeLayout layout;
    QueryInfo info;

    private final String stylesheet = "" +
            "sprite { " +
            " shape: flow; " +
            " size: 5px;" +
            " z-index: 0; " +
            " sprite-orientation: from;" +
            " fill-color: green;" +
            "} " +
            "" +
            "node {" +
            " size: 16px;" +
            " fill-color: #d3d3d3;" +
            " text-color: white;" +
            " text-style: bold;" +
            " text-padding: 2px;" +
            " text-size: 12px;" +
            " text-background-mode: rounded-box;" +
            " text-background-color: rgb(35, 47, 62);" +
            "}";


    public void init(QueryInfo info) {
        this.info = info;
        Logger.getLogger(LayoutRunner.class.getSimpleName()).setUseParentHandlers(false);

        System.setProperty("org.graphstream.ui.renderer",
                "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
        graph = new SingleGraph("Join Order");
        viewer = graph.display();
        viewer.setCloseFramePolicy(Viewer.CloseFramePolicy.CLOSE_VIEWER);
        viewer.disableAutoLayout();


        layout = new TreeLayout();
        layout.addSink(graph);
        graph.addSink(layout);

        View view = viewer.getDefaultView();
        for (MouseListener listener : ((ViewPanel) view).getMouseListeners()) {
            view.removeMouseListener(listener);
        }
        view.addMouseListener(this);

        spriteManager = new SpriteManager(graph);
        graph.setAttribute("ui.stylesheet", stylesheet);
        graph.setAttribute("ui.antialias");
        graph.setAttribute("ui.quality");
        graph.addNode("root").addAttribute("ui.label", "Join");
    }

    public void createNodesSpriteIfNotPresent(int[] joinOrder) {
        String currentJoinNode = "";
        String previous = "root";
        for (int x : joinOrder) {
            String tableName = info.aliasToTable.get(info.aliases[x]);

            currentJoinNode += (char) (65 + x);
            if (graph.getNode(currentJoinNode) == null) {
                Node newNode = graph.addNode(currentJoinNode);
                newNode.addAttribute("ui.label", tableName);
                Edge edge = graph.addEdge(previous + "--" + currentJoinNode,
                        previous, currentJoinNode, true);
                Sprite sprite = spriteManager.addSprite("S#" + previous +
                        "--" + currentJoinNode);
                sprite.attachToEdge(edge.getId());
                sprite.setPosition(0);
                sleep(8);
            }
            previous = currentJoinNode;
        }
    }

    public void update(int[] joinOrder, double reward, int[] tupleIndices,
                       int[] tableCardinality) {
        createNodesSpriteIfNotPresent(joinOrder);

        String currentJoinNode = "";
        String previous = "root";
        for (int currentTable : joinOrder) {
            currentJoinNode += (char) (65 + currentTable);
            Sprite sprite = spriteManager.getSprite("S#" + previous +
                    "--" + currentJoinNode);
            sprite.setPosition(tupleIndices[currentTable] /
                    (double) tableCardinality[currentTable]);
            previous = currentJoinNode;
        }

        layout.compute();
        sleep(2000);
    }

    @Override
    public void mouseClicked(MouseEvent e) {}

    @Override
    public void mousePressed(MouseEvent e) {}

    @Override
    public void mouseReleased(MouseEvent e) {}

    @Override
    public void mouseEntered(MouseEvent e) {}

    @Override
    public void mouseExited(MouseEvent e) {}

    private void sleep(int ms) {
        try {
            Thread.sleep(ms);
        } catch (InterruptedException e) {}
    }
}