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
		
		[Embed(source = "../../../../audio/crescendo.mp3")]
		public static var CrescendoSound:Class;
		[Embed(source = "../../../../audio/validation.mp3")]
		public static var ValidationSound:Class;
		[Embed(source = "../../../../audio/error.mp3")]
		public static var ErrorSound:Class;
		
		[Embed(source = "../../../../audio/instruction.mp3")]
		public static var InstructionSound:Class;
		
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
		public static var WordSound:Object = { hill:Hill, felt:Felt, hall:Hall, clam:Clam, leaf:Leaf, surf:Surf, fair:Fair };
		
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
		public static var LetterSound:Object = { h:H, i:I, l:L, f:F, e:E, t:T, a:A, c:C, m:M, s:S, u:U, r:R };
		
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
		public static var ChunkSound:Object = { ill:Ill, ll:Ll, lt:Lt, elt:Elt, all:All, cl:Cl, am:Am, af:Af, rf:Rf, urf:Urf, ir:Ir };
		
		public function Asset()
		{
			throw new Error("Asset is a static class not intended for instantiation!");
		}
	}
}