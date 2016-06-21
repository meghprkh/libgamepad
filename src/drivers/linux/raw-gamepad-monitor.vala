private class LibGamepad.LinuxRawGamepadMonitor : Object, RawGamepadMonitor {
	private GUdev.Client client;

	public LinuxRawGamepadMonitor () {
		client = new GUdev.Client({"input"});
		client.uevent.connect(udev_client_callback);
	}

	public delegate void ForeachGamepadCallback (RawGamepad raw_gamepad);
	public void foreach_gamepad (ForeachGamepadCallback cb) {
		client.query_by_subsystem("input").foreach((dev) => {
			if (dev.get_device_file() == null) return;
			var identifier = dev.get_device_file();
			if ((dev.has_property("ID_INPUT_JOYSTICK") && dev.get_property("ID_INPUT_JOYSTICK") == "1") ||
				(dev.has_property(".INPUT_CLASS") && dev.get_property(".INPUT_CLASS") == "joystick")) {
				RawGamepad raw_gamepad;
				try {
					raw_gamepad = new LinuxRawGamepad (identifier);
				} catch (FileError err) {
					return;
				}
				cb (raw_gamepad);
			}
		});
	}

	private void udev_client_callback (string action, GUdev.Device dev) {
		if (dev.get_device_file() == null) return;
		var identifier = dev.get_device_file();
		if ((dev.has_property("ID_INPUT_JOYSTICK") && dev.get_property("ID_INPUT_JOYSTICK") == "1") ||
			(dev.has_property(".INPUT_CLASS") && dev.get_property(".INPUT_CLASS") == "joystick")) {
			if (action == "add") {
				RawGamepad raw_gamepad;
				try {
					raw_gamepad = new LinuxRawGamepad (identifier);
				} catch (FileError err) {
					return;
				}
				on_plugin (raw_gamepad);
			} else if (action == "remove") {
				on_unplug (identifier);
			}
		}
	}
}
