package haxepunk;

/**
 * A simple structure to contain the coordinates of a position in 2D space.
 * Unifies with any object that has x:Float and y:Float variables.
 */
@:dox(hide)
private typedef PositionData =
{
	x:Float,
	y:Float
};

/**
 * Same as PositionData, but unifies with objects (such as Entity)
 * whose x and y are properties, not variables.
 */
@:dox(hide)
private typedef PositionPropsData =
{
	@:isVar var x(get, set):Float;
	@:isVar var y(get, set):Float;
};

/**
 * Represents a position on a two dimensional coordinate system.
 *
 * Conversion from a `{ x:Float, y:Float }` or a `Entity` is automatic, no need to use this.
 */
abstract Position(PositionData) from PositionData to PositionData
{
	public function new(?obj:Dynamic)
	{
		if (obj == null) obj = {x: 0, y: 0};
		this = obj;
	}

	public var x(get, set):Float;
	inline function get_x():Float return this.x;
	inline function set_x(value:Float):Float return this.x = value;

	public var y(get, set):Float;
	inline function get_y():Float return this.y;
	inline function set_y(value:Float):Float return this.y = value;

	public var length(get, never):Float;
	inline function get_length():Float return Math.sqrt(x * x + y * y);

	@:dox(hide) @:from public static inline function fromProps(obj:PositionPropsData) return new Position(obj);

	public inline function normalize(thickness:Float):Void
	{
		if (x != 0 || y != 0)
		{
			var norm = thickness / Math.sqrt(x * x + y * y);
			x *= norm;
			y *= norm;
		}
	}
}
