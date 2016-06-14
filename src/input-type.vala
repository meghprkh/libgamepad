public enum LibGamepad.InputType {
	AXIS,
	BUTTON,
	INVALID;

	public static uint length () {
		return InputType.INVALID + 1;
	}
}
