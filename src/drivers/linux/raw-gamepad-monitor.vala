private class LibGamepad.LinuxRawGamepadMonitor : Object, RawGamepadMonitor {
	private GUdev.Client client;

	public LinuxRawGamepadMonitor () {
		client = new GUdev.Client({"input"});
		client.uevent.connect(udev_client_callback);
	}

	public delegate void ForeachGamepadCallback(string identifier, Guid guid, string? raw_name = null);
	public void foreach_gamepad (ForeachGamepadCallback cb) {
		client.query_by_subsystem("input").foreach((dev) => {
			if (dev.get_device_file() == null) return;
			var identifier = dev.get_device_file();
			if ((dev.has_property("ID_INPUT_JOYSTICK") && dev.get_property("ID_INPUT_JOYSTICK") == "1") ||
				(dev.has_property(".INPUT_CLASS") && dev.get_property(".INPUT_CLASS") == "joystick")) {
				var fd = Posix.open (identifier, Posix.O_RDONLY | Posix.O_NONBLOCK);
				if (fd < 0) return;
				var evdev = new Libevdev.Evdev();
				if (evdev.set_fd(fd) < 0) return;
				cb (identifier, LibGamepad.LinuxGuidHelpers.from_dev(evdev), evdev.name);
			}
		});
	}

	private void udev_client_callback (string action, GUdev.Device dev) {
		if (dev.get_device_file() == null) return;
		var identifier = dev.get_device_file();
		if ((dev.has_property("ID_INPUT_JOYSTICK") && dev.get_property("ID_INPUT_JOYSTICK") == "1") ||
			(dev.has_property(".INPUT_CLASS") && dev.get_property(".INPUT_CLASS") == "joystick")) {
			if (action == "add") {
				var fd = Posix.open (identifier, Posix.O_RDONLY | Posix.O_NONBLOCK);
				if (fd < 0) return;
				var evdev = new Libevdev.Evdev();
				if (evdev.set_fd(fd) < 0) return;
				on_plugin (identifier, LibGamepad.LinuxGuidHelpers.from_dev(evdev), evdev.name);
			} else if (action == "remove") {
				on_unplug (identifier);
			}
		}
	}
}
