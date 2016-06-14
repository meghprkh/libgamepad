/**
 * This is one of the interfaces that needs to be implemented by the driver.
 *
 * This interface represents a gamepad and deals with handling events that are
 * emitted by a gamepad and also provide properties like name and guid along
 * with number of buttons, axes and hats.
 *
 * The constructor takes a identifier as a parameter.
 * @see RawGamepadMonitor
 */
public interface LibGamepad.RawGamepad : Object {
	/**
	 * Emitted when a button is pressed/released
	 * @param  code          The button code from 0 to nbuttons
	 * @param  value         True if pressed, False if released
	 */
	public abstract signal void button_event (int code, bool value);
	/**
	 * Emitted when an axis's value changes
	 * @param  axis          The axis number from 0 to naxes
	 * @param  value         The value of the axis ranging from -1 to 1
	 */
	public abstract signal void axis_event (int axis, double value);
	/**
	 * Emitted when a hat's axis's value changes
	 * @param  hat           The hat number from 0 to
	 * @param  axis          The axis: 0 for X, 1 for Y
	 * @param  value         The value of the axis ranging from -1 to 1
	 */
	public abstract signal void hat_event (int hat, int axis, int value);
	/**
	 * Emitted when the gamepad is unplugged
	 */
	public abstract signal void unplug ();

	public abstract string name { get; protected set; }
	public abstract Guid guid { get; protected set; }

	/**
	 * Number of axes of the gamepad
	 */
	public abstract uint8 naxes { get; protected set; default = 0; }
	/**
	 * Number of buttons of the gamepad
	 */
	public abstract uint8 nbuttons { get; protected set; default = 0; }
	/**
	 * Number of hats of the gamepad`
	 */
	public abstract uint8 nhats { get; protected set; default = 0; }
}
