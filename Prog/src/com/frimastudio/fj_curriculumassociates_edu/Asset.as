package com.frimastudio.fj_curriculumassociates_edu
{
	public class Asset
	{
		[Embed(source = "../../../../art/TheFieldIsOnAHill.png")]
		public static var TheFieldIsOnAHillBitmap:Class;
		
		[Embed(source = "../../../../audio/click.mp3")]
		public static var ClickSound:Class;
		[Embed(source = "../../../../audio/slide.mp3")]
		public static var SlideSound:Class;
		[Embed(source = "../../../../audio/snapping.mp3")]
		public static var SnappingSound:Class;
		
		[Embed(source = "../../../../audio/crescendo.mp3")]
		public static var CrescendoSound:Class;
		[Embed(source = "../../../../audio/validation.mp3")]
		public static var ValidationSound:Class;
		[Embed(source = "../../../../audio/error.mp3")]
		public static var ErrorSound:Class;
		
		[Embed(source = "../../../../audio/instruction.mp3")]
		public static var InstructionSound:Class;
		
		[Embed(source = "../../../../audio/sentences/aFieldIsOnTheHill.mp3")]
		private static var AFieldIsOnTheHill:Class;
		[Embed(source = "../../../../audio/sentences/onAHillIsTheField.mp3")]
		private static var OnAHillIsTheField:Class;
		[Embed(source = "../../../../audio/sentences/onTheHillIsAField.mp3")]
		private static var OnTheHillIsAField:Class;
		[Embed(source = "../../../../audio/sentences/theFieldIsOnAHill.mp3")]
		private static var TheFieldIsOnAHill:Class;
		public static var SentenceSound:Object = { _a_field_is_on_the_hill:AFieldIsOnTheHill,
			_on_a_hill_is_the_field:OnAHillIsTheField, _on_the_hill_is_a_field:OnTheHillIsAField,
			_the_field_is_on_a_hill:TheFieldIsOnAHill };
		
		[Embed(source = "../../../../audio/words/hill.mp3")]
		private static var Hill:Class;
		[Embed(source = "../../../../audio/words/felt.mp3")]
		private static var Felt:Class;
		[Embed(source = "../../../../audio/words/hall.mp3")]
		private static var Hall:Class;
		[Embed(source = "../../../../audio/words/clam.mp3")]
		private static var Clam:Class;
		[Embed(source = "../../../../audio/words/leaf.mp3")]
		private static var Leaf:Class;
		[Embed(source = "../../../../audio/words/surf.mp3")]
		private static var Surf:Class;
		[Embed(source = "../../../../audio/words/fair.mp3")]
		private static var Fair:Class;
		[Embed(source = "../../../../audio/words/a.mp3")]
		private static var WordA:Class;
		[Embed(source = "../../../../audio/words/field.mp3")]
		private static var Field:Class;
		[Embed(source = "../../../../audio/words/is.mp3")]
		private static var Is:Class;
		[Embed(source = "../../../../audio/words/on.mp3")]
		private static var On:Class;
		[Embed(source = "../../../../audio/words/sun.mp3")]
		private static var Sun:Class;
		[Embed(source = "../../../../audio/words/the.mp3")]
		private static var The:Class;
		public static var WordSound:Object = { _hill:Hill, _felt:Felt, _hall:Hall, _clam:Clam, _leaf:Leaf, _surf:Surf,
			_fair:Fair, _a:WordA, _field:Field, _is:Is, _on:On, _sun:Sun, _the:The };
		
		[Embed(source = "../../../../audio/letters/h.mp3")]
		private static var H:Class;
		[Embed(source = "../../../../audio/letters/i.mp3")]
		private static var I:Class;
		[Embed(source = "../../../../audio/letters/l.mp3")]
		private static var L:Class;
		[Embed(source = "../../../../audio/letters/f.mp3")]
		private static var F:Class;
		[Embed(source = "../../../../audio/letters/e.mp3")]
		private static var E:Class;
		[Embed(source = "../../../../audio/letters/t.mp3")]
		private static var T:Class;
		[Embed(source = "../../../../audio/letters/a.mp3")]
		private static var A:Class;
		[Embed(source = "../../../../audio/letters/c.mp3")]
		private static var C:Class;
		[Embed(source = "../../../../audio/letters/m.mp3")]
		private static var M:Class;
		[Embed(source = "../../../../audio/letters/s.mp3")]
		private static var S:Class;
		[Embed(source = "../../../../audio/letters/u.mp3")]
		private static var U:Class;
		[Embed(source = "../../../../audio/letters/r.mp3")]
		private static var R:Class;
		public static var LetterSound:Object = { _h:H, _i:I, _l:L, _f:F, _e:E, _t:T, _a:A, _c:C, _m:M, _s:S, _u:U, _r:R };
		
		[Embed(source = "../../../../audio/chunks/ill.mp3")]
		private static var Ill:Class;
		[Embed(source = "../../../../audio/chunks/ll.mp3")]
		private static var Ll:Class;
		[Embed(source = "../../../../audio/chunks/lt.mp3")]
		private static var Lt:Class;
		[Embed(source = "../../../../audio/chunks/elt.mp3")]
		private static var Elt:Class;
		[Embed(source = "../../../../audio/chunks/all.mp3")]
		private static var All:Class;
		[Embed(source = "../../../../audio/chunks/cl.mp3")]
		private static var Cl:Class;
		[Embed(source = "../../../../audio/chunks/am.mp3")]
		private static var Am:Class;
		[Embed(source = "../../../../audio/chunks/af.mp3")]
		private static var Af:Class;
		[Embed(source = "../../../../audio/chunks/rf.mp3")]
		private static var Rf:Class;
		[Embed(source = "../../../../audio/chunks/urf.mp3")]
		private static var Urf:Class;
		[Embed(source = "../../../../audio/chunks/ir.mp3")]
		private static var Ir:Class;
		public static var ChunkSound:Object = { _ill:Ill, _ll:Ll, _lt:Lt, _elt:Elt, _all:All, _cl:Cl, _am:Am, _af:Af,
			_rf:Rf, _urf:Urf, _ir:Ir };
		
		public function Asset()
		{
			throw new Error("Asset is a static class not intended for instantiation!");
		}
	}
}