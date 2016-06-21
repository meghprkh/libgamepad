/**
 * This is one of the interfaces that needs to be implemented by the driver.
 *
 * This interface deals with handling events related to plugging and unplugging
 * of gamepads and also provides a method to iterate through all the plugged in
 * gamepads. An identifier is a string that is easily understood by the driver
 * and may depend on other factors, i.e. it may not be unique for the gamepad.
 */
public interface LibGamepad.RawGamepadMonitor : Object {
	/**
	 * This signal should be emmited when a gamepad is plugged in.
	 * @param   raw_gamepad   The raw gamepad
	 */
	public abstract signal void on_plugin (RawGamepad raw_gamepad);

	/**
	 * This signal should be emitted when a gamepad is unplugged
	 *
	 * If an identifier which is not passed with on_plugin even once is passed,
	 * then it is ignored. Drivers may use this to their benefit
	 *
	 * @param  identifier    The identifier of the unplugged gamepad
	 */
	public abstract signal void on_unplug (string identifier);

	public delegate void ForeachGamepadCallback (RawGamepad raw_gamepad);

	/**
	 * This function allows to iterate over all gamepads
	 * @param   cb            The callback
	 */
	public abstract void foreach_gamepad (ForeachGamepadCallback cb);
}
