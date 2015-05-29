package com.frimastudio.fj_curriculumassociates_edu
{
	public class Asset
	{
		[Embed(source = "../../../../art/TheFieldIsOnAHill.png")]
		public static var TheFieldIsOnAHillBitmap:Class;
		
		[Embed(source = "../../../../art/POC/BtnLeft.png")]
		public static var BtnLeftBitmap:Class;
		[Embed(source = "../../../../art/POC/BtnTrash.png")]
		public static var BtnTrashBitmap:Class;
		[Embed(source = "../../../../art/POC/BtnRight.png")]
		public static var BtnRightBitmap:Class;
		[Embed(source = "../../../../art/POC/BtnEar.png")]
		public static var BtnEarBitmap:Class;
		[Embed(source = "../../../../art/POC/BtnFeed.png")]
		public static var BtnFeedBitmap:Class;
		[Embed(source = "../../../../art/POC/BtnWrite.png")]
		public static var BtnWriteBitmap:Class;
		
		[Embed(source = "../../../../art/POC/IconHint.png")]
		public static var IconHintBitmap:Class;
		[Embed(source = "../../../../art/POC/IconOK.png")]
		public static var IconOKBitmap:Class;
		[Embed(source = "../../../../art/POC/IconWrite.png")]
		public static var IconWriteBitmap:Class;
		[Embed(source = "../../../../art/POC/IconWrong.png")]
		public static var IconWrongBitmap:Class;
		[Embed(source = "../../../../art/POC/IconEar.png")]
		public static var IconEarBitmap:Class;
		
		[Embed(source = "../../../../art/POC/Bubble.png")]
		public static var BubbleBitmap:Class;
		[Embed(source = "../../../../art/POC/BubbleSplash.png")]
		public static var BubbleSplashBitmap:Class;
		
		[Embed(source = "../../../../art/POC/NPC.png")]
		public static var NPCBitmap:Class;
		[Embed(source = "../../../../art/POC/Mini.png")]
		public static var MiniBitmap:Class;
		[Embed(source = "../../../../art/POC/Cup.png")]
		public static var CupBitmap:Class;
		[Embed(source = "../../../../art/POC/Field.png")]
		public static var FieldBitmap:Class;
		
		[Embed(source = "../../../../art/lesson/requestTube.png")]
		public static var RequestTubeBitmap:Class;
		[Embed(source = "../../../../art/lesson/lucu.png")]
		public static var LucuBitmap:Class;
		[Embed(source = "../../../../art/lesson/flashlightLucu.png")]
		public static var FlashlightLucuBitmap:Class;
		[Embed(source = "../../../../art/lesson/flashlight.png")]
		public static var FlashlightBitmap:Class;
		
		[Embed(source = "../../../../art/lesson/thorn.png")]
		public static var ThornBitmap:Class;
		[Embed(source = "../../../../art/lesson/sports.png")]
		public static var SportsBitmap:Class;
		[Embed(source = "../../../../art/lesson/store.png")]
		public static var StoreBitmap:Class;
		
		[Embed(source = "../../../../art/lesson/lamp1_on.png")]
		private static var Lamp1On:Class;
		[Embed(source = "../../../../art/lesson/lamp2_on.png")]
		private static var Lamp2On:Class;
		[Embed(source = "../../../../art/lesson/lamp3_on.png")]
		private static var Lamp3On:Class;
		public static var LampOnBitmap:Object = [Lamp1On, Lamp2On, Lamp3On];
		
		[Embed(source = "../../../../art/lesson/lamp1_off.png")]
		private static var Lamp1Off:Class;
		[Embed(source = "../../../../art/lesson/lamp2_off.png")]
		private static var Lamp2Off:Class;
		[Embed(source = "../../../../art/lesson/lamp3_off.png")]
		private static var Lamp3Off:Class;
		public static var LampOffBitmap:Object = [Lamp1Off, Lamp2Off, Lamp3Off];
		
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
		[Embed(source = "../../../../audio/sentences/iAmSam.mp3")]
		private static var IAmSam:Class;
		[Embed(source = "../../../../audio/sentences/iNeedToFillUpThisCup.mp3")]
		private static var INeedToFillUpThisCup:Class;
		public static var SentenceSound:Object = { _a_field_is_on_the_hill:AFieldIsOnTheHill,
			_on_a_hill_is_the_field:OnAHillIsTheField, _on_the_hill_is_a_field:OnTheHillIsAField,
			_the_field_is_on_a_hill:TheFieldIsOnAHill, _i_am_sam:IAmSam, _i_need_to_fill_up_this_cup:INeedToFillUpThisCup };
		
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
		[Embed(source = "../../../../audio/letters/p.mp3")]
		private static var P:Class;
		[Embed(source = "../../../../audio/letters/o.mp3")]
		private static var O:Class;
		[Embed(source = "../../../../audio/letters/g.mp3")]
		private static var G:Class;
		public static var LetterSound:Object = { _h:H, _i:I, _l:L, _f:F, _e:E, _t:T, _a:A, _c:C, _m:M, _s:S, _u:U, _r:R,
			_p:P, _o:O, _g:G };
		
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
		
		[Embed(source = "../../../../audio/lesson/thorn.mp3")]
		public static var ThornSound:Class;
		[Embed(source = "../../../../audio/lesson/sports.mp3")]
		public static var SportsSound:Class;
		[Embed(source = "../../../../audio/lesson/store.mp3")]
		public static var StoreSound:Class;
		
		[Embed(source = "../../../../font/sweater school rg.otf", fontName = "SweaterSchoolRg-Regular",
			mimeType = "application/x-font", fontWeight = "normal", fontStyle = "normal", embedAsCFF = "false")]
		public static var SweaterSchoolFont:Class;
		
		[Embed(source = "../../../../font/sweater school sb.otf", fontName = "SweaterSchoolSb-Regular",
			mimeType = "application/x-font", fontWeight = "normal", fontStyle = "normal", embedAsCFF = "false")]
		public static var SweaterSchoolSemiBoldFont:Class;
		
		[Embed(source = "../../../../font/sweater school bd.otf", fontName = "SweaterSchoolRg-Bold",
			mimeType = "application/x-font", fontWeight = "bold", fontStyle = "normal", embedAsCFF = "false")]
		public static var SweaterSchoolBoldFont:Class;
		
		[Embed(source = "../../../../font/sweater school xb.otf", fontName = "SweaterSchoolXb-Regular",
			mimeType = "application/x-font", fontWeight = "normal", fontStyle = "normal", embedAsCFF = "false")]
		public static var SweaterSchoolExtraBoldFont:Class;
		
		public function Asset()
		{
			throw new Error("Asset is static and not intended for instantiation!");
		}
	}
}