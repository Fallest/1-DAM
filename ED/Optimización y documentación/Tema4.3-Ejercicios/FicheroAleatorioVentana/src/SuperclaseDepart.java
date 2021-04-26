
import java.awt.GraphicsConfiguration;
import java.awt.HeadlessException;
import java.awt.event.ActionListener;

import javax.swing.JFrame;

public class SuperclaseDepart extends JFrame {

	public SuperclaseDepart() throws HeadlessException {
		super();
	}

	public SuperclaseDepart(GraphicsConfiguration gc) {
		super(gc);
	}

	public SuperclaseDepart(String title) throws HeadlessException {
		super(title);
	}

	public SuperclaseDepart(String title, GraphicsConfiguration gc) {
		super(title, gc);
	}

}