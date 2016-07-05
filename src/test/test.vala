int main () {
	var gamepad_monitor = new LibGamepad.GamepadMonitor ();

	// This array will store our gamepads
	LibGamepad.Gamepad[] gamepads = {};

	// On plugin, connect signals to the gamepad and store it in the gamepads array so it is not deleted by reference counting
	gamepad_monitor.gamepad_plugged.connect ((gamepad) => {
		print (@"GM Plugged in $(gamepad.raw_gamepad.identifier) - $(gamepad.guid) - $(gamepad.name)\n");
		gamepads += gamepad;
		// Bind events
		gamepad.button_event.connect ((button, value) => print (@"$(gamepad.name) - $(button.to_string ()) - $value\n"));
		gamepad.axis_event.connect ((axis, value) => print (@"$(gamepad.name) - $(axis.to_string ()) - $value\n"));
		gamepad.unplugged.connect (() => print (@"$(gamepad.name) - G Unplugged\n"));
	});

	// On unplug, output simple message (No need to remove from the gamepads array)
	gamepad_monitor.gamepad_unplugged.connect ((identifier, guid, name) => print (@"GM Unplugged $identifier - $guid - $name\n"));

	// Initialize initially plugged in gamepads
	gamepad_monitor.foreach_gamepad ((gamepad) => {
		print (@"GM Initially Plugged in $(gamepad.raw_gamepad.identifier) - $(gamepad.guid) - $(gamepad.name)\n");
		gamepads += gamepad;
		// Bind events
		gamepad.button_event.connect ((button, value) => print (@"$(gamepad.name) - $(button.to_string ()) - $value\n"));
		gamepad.axis_event.connect ((axis, value) => print (@"$(gamepad.name) - $(axis.to_string ()) - $value\n"));
		gamepad.unplugged.connect (() => print (@"$(gamepad.name) - G Unplugged\n"));
	});

	new MainLoop ().run ();
	return 0;
}
