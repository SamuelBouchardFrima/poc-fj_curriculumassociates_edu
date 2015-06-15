package com.frimastudio.fj_curriculumassociates_edu
{
	import flash.display.MovieClip;
	import flash.text.Font;
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
		[Embed(source = "../../../../art/POC/LucuSentenceUnscrambling.png")]
		public static var LucuSentenceUnscramblingBitmap:Class;
		[Embed(source = "../../../../art/POC/Mini.png")]
		public static var MiniBitmap:Class;
		[Embed(source = "../../../../art/POC/MiniOpen.png")]
		public static var MiniOpenBitmap:Class;
		[Embed(source = "../../../../art/POC/Cup.png")]
		public static var CupBitmap:Class;
		[Embed(source = "../../../../art/POC/Field.png")]
		public static var FieldBitmap:Class;
		
		[Embed(source = "../../../../art/lesson/labLucu.png")]
		public static var LabLucuBitmap:Class;
		[Embed(source = "../../../../art/lesson/labCounter.png")]
		public static var LabCounterBitmap:Class;
		[Embed(source = "../../../../art/lesson/curtain.png")]
		public static var CurtainBitmap:Class;
		
		[Embed(source = "../../../../art/lesson/lesson_1.png")]
		private static var Lesson1:Class;
		[Embed(source = "../../../../art/lesson/lesson_2.png")]
		private static var Lesson2:Class;
		[Embed(source = "../../../../art/lesson/lesson_3.png")]
		private static var Lesson3:Class;
		[Embed(source = "../../../../art/lesson/lesson_4.png")]
		private static var Lesson4:Class;
		[Embed(source = "../../../../art/lesson/lesson_5.png")]
		private static var Lesson5:Class;
		public static var LessonBitmap:Object = [Lesson1, Lesson2, Lesson3, Lesson4, Lesson5];
		
		[Embed(source = "../../../../art/lesson/requestTube.png")]
		public static var RequestTubeBitmap:Class;
		[Embed(source = "../../../../art/lesson/flashlightLucu.png")]
		public static var FlashlightLucuBitmap:Class;
		[Embed(source = "../../../../art/lesson/handheldFlashlight.png")]
		public static var FlashlightBitmap:Class;
		[Embed(source = "../../../../art/lesson/newCircuitLucu.png")]
		public static var NewCircuitLucuBitmap:Class;
		[Embed(source = "../../../../art/lesson/btncontinue.png")]
		public static var ContinueBtnLucuBitmap:Class;
		
		[Embed(source = "../../../../art/lesson/newLucu_1.png")]
		private static var NewLucu1:Class;
		[Embed(source = "../../../../art/lesson/newLucu_2.png")]
		private static var NewLucu2:Class;
		[Embed(source = "../../../../art/lesson/newLucu_3.png")]
		private static var NewLucu3:Class;
		public static var NewLucuBitmap:Object = [NewLucu1, NewLucu2, NewLucu3];
		
		[Embed(source = "../../../../art/lesson/newLucuAngry_1.png")]
		private static var NewLucuAngry1:Class;
		[Embed(source = "../../../../art/lesson/newLucuAngry_2.png")]
		private static var NewLucuAngry2:Class;
		[Embed(source = "../../../../art/lesson/newLucuAngry_3.png")]
		private static var NewLucuAngry3:Class;
		public static var NewLucuAngryBitmap:Object = [NewLucuAngry1, NewLucuAngry2, NewLucuAngry3];
		
		[Embed(source = "../../../../art/lesson/thorn.png")]
		public static var ThornBitmap:Class;
		[Embed(source = "../../../../art/lesson/sports.png")]
		public static var SportsBitmap:Class;
		[Embed(source = "../../../../art/lesson/store.png")]
		public static var StoreBitmap:Class;
		[Embed(source = "../../../../art/lesson/fork.png")]
		public static var ForkBitmap:Class;
		[Embed(source = "../../../../art/lesson/park.png")]
		public static var ParkBitmap:Class;
		[Embed(source = "../../../../art/lesson/fish.png")]
		public static var FishBitmap:Class;
		[Embed(source = "../../../../art/lesson/horse.png")]
		public static var HorseBitmap:Class;
		[Embed(source = "../../../../art/lesson/horn.png")]
		public static var HornBitmap:Class;
		[Embed(source = "../../../../art/lesson/card.png")]
		public static var CardBitmap:Class;
		[Embed(source = "../../../../art/lesson/torch.png")]
		public static var TorchBitmap:Class;
		[Embed(source = "../../../../art/lesson/top.png")]
		public static var TopBitmap:Class;
		[Embed(source = "../../../../art/lesson/barn.png")]
		public static var BarnBitmap:Class;
		
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
		
		[Embed(source = "../../../../art/lesson/circuit_on.png")]
		public static var CircuitOn:Class;
		[Embed(source = "../../../../art/lesson/circuit_off.png")]
		public static var CircuitOff:Class;
		[Embed(source = "../../../../art/lesson/circuit_disabled.png")]
		public static var CircuitDisabled:Class;
		[Embed(source = "../../../../art/lesson/circuitConnection_on.png")]
		public static var CircuitConnectionOn:Class;
		[Embed(source = "../../../../art/lesson/circuitConnection.png")]
		public static var CircuitConnection:Class;
		
		[Embed(source = "../../../../art/lesson/circuit/star.png")]
		private static var CircuitStarBitmap:Class;
		[Embed(source = "../../../../art/lesson/circuit/coat.png")]
		private static var CircuitCoatBitmap:Class;
		[Embed(source = "../../../../art/lesson/circuit/storm.png")]
		private static var CircuitStormBitmap:Class;
		[Embed(source = "../../../../art/lesson/circuit/fort.png")]
		private static var CircuitFortBitmap:Class;
		[Embed(source = "../../../../art/lesson/circuit/hand.png")]
		private static var CircuitHandBitmap:Class;
		[Embed(source = "../../../../art/lesson/circuit/snow.png")]
		private static var CircuitSnowBitmap:Class;
		[Embed(source = "../../../../art/lesson/circuit/horn.png")]
		private static var CircuitHornBitmap:Class;
		[Embed(source = "../../../../art/lesson/circuit/hat.png")]
		private static var CircuitHatBitmap:Class;
		public static var CircuitBitmap:Object = { _star:CircuitStarBitmap, _coat:CircuitCoatBitmap, _storm:CircuitStormBitmap,
			_fort:CircuitFortBitmap, _hand:CircuitHandBitmap, _snow:CircuitSnowBitmap, _horn:CircuitHornBitmap,
			_hat:CircuitHatBitmap };
		
		[Embed(source = "../../../../art/lesson/familyBox_1.png")]
		private static var FamilyBox1:Class;
		[Embed(source = "../../../../art/lesson/familyBox_2.png")]
		private static var FamilyBox2:Class;
		[Embed(source = "../../../../art/lesson/familyBox_3.png")]
		private static var FamilyBox3:Class;
		[Embed(source = "../../../../art/lesson/familyBox_4.png")]
		private static var FamilyBox4:Class;
		public static var FamilyBoxBitmap:Object = [FamilyBox1, FamilyBox2, FamilyBox3, FamilyBox4];
		
		[Embed(source = "../../../../art/POC/SubmissionHighlight.png")]
		public static var SubmissionHighlightBitmap:Class;
		
		[Embed(source = "../../../../anim/PieceExplosion.swf")]
		public static var PieceExplosionClip:Class;
		[Embed(source = "../../../../anim/TrayExplosion.swf")]
		public static var TrayExplosionClip:Class;
		
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
		
		[Embed(source = "../../../../audio/lesson/thatSIt.mp3")]
		private static var ThatSIt:Class;
		[Embed(source = "../../../../audio/lesson/thatSRight.mp3")]
		private static var ThatSRight:Class;
		[Embed(source = "../../../../audio/lesson/right.mp3")]
		private static var Right:Class;
		public static var PositiveFeedbackSound:Object = [ThatSIt, ThatSRight, Right];
		[Embed(source = "../../../../audio/lesson/clickToContinue.mp3")]
		public static var ClickToContinueSound:Class;
		
		[Embed(source = "../../../../audio/lesson/spotlight/glow.mp3")]
		private static var SpotlightGlow:Class;
		[Embed(source = "../../../../audio/lesson/spotlight/snore.mp3")]
		private static var SpotlightSnore:Class;
		[Embed(source = "../../../../audio/lesson/spotlight/jar.mp3")]
		private static var SpotlightJar:Class;
		[Embed(source = "../../../../audio/lesson/spotlight/core.mp3")]
		private static var SpotlightCore:Class;
		[Embed(source = "../../../../audio/lesson/spotlight/car.mp3")]
		private static var SpotlightCar:Class;
		[Embed(source = "../../../../audio/lesson/spotlight/card.mp3")]
		private static var SpotlightCard:Class;
		[Embed(source = "../../../../audio/lesson/spotlight/throne.mp3")]
		private static var SpotlightThrone:Class;
		[Embed(source = "../../../../audio/lesson/spotlight/start.mp3")]
		private static var SpotlightStart:Class;
		[Embed(source = "../../../../audio/lesson/spotlight/score.mp3")]
		private static var SpotlightScore:Class;
		public static var SpotlightSound:Object = { _glow:SpotlightGlow, _snore:SpotlightSnore, _jar:SpotlightJar,
			_core:SpotlightCore, _car:SpotlightCar, _card:SpotlightCard,
			_score:SpotlightScore, _start:SpotlightStart, _throne:SpotlightThrone };
		
		[Embed(source = "../../../../audio/lesson/spotlight/snoreCorrect.mp3")]
		private static var SpotlightCorrectSnore:Class;
		[Embed(source = "../../../../audio/lesson/spotlight/coreCorrect.mp3")]
		private static var SpotlightCorrectCore:Class;
		[Embed(source = "../../../../audio/lesson/spotlight/scoreCorrect.mp3")]
		private static var SpotlightCorrectScore:Class;
		public static var SpotlightCorrectSound:Object = { _snore:SpotlightCorrectSnore,
			_core:SpotlightCorrectCore, _score:SpotlightCorrectScore };
		
		[Embed(source = "../../../../audio/lesson/flashlight/thorn.mp3")]
		private static var FlashlightThorn:Class;
		[Embed(source = "../../../../audio/lesson/flashlight/sports.mp3")]
		private static var FlashlightSports:Class;
		[Embed(source = "../../../../audio/lesson/flashlight/store.mp3")]
		private static var FlashlightStore:Class;
		[Embed(source = "../../../../audio/lesson/flashlight/fork.mp3")]
		private static var FlashlightFork:Class;
		[Embed(source = "../../../../audio/lesson/flashlight/park.mp3")]
		private static var FlashlightPark:Class;
		[Embed(source = "../../../../audio/lesson/flashlight/fish.mp3")]
		private static var FlashlightFish:Class;
		[Embed(source = "../../../../audio/lesson/flashlight/torch.mp3")]
		private static var FlashlightTorch:Class;
		[Embed(source = "../../../../audio/lesson/flashlight/top.mp3")]
		private static var FlashlightTop:Class;
		[Embed(source = "../../../../audio/lesson/flashlight/barn.mp3")]
		private static var FlashlightBarn:Class;
		public static var FlashlightSound:Object = { _thorn:FlashlightThorn, _sports:FlashlightSports, _store:FlashlightStore,
			_fork:FlashlightFork, _park:FlashlightPark, _fish:FlashlightFish,
			_torch:FlashlightTorch, _top:FlashlightTop, _barn:FlashlightBarn };
		
		[Embed(source = "../../../../audio/lesson/circuit/bar.mp3")]
		private static var CircuitBar:Class;
		[Embed(source = "../../../../audio/lesson/circuit/bark.mp3")]
		private static var CircuitBark:Class;
		[Embed(source = "../../../../audio/lesson/circuit/boat.mp3")]
		private static var CircuitBoat:Class;
		[Embed(source = "../../../../audio/lesson/circuit/bow.mp3")]
		private static var CircuitBow:Class;
		[Embed(source = "../../../../audio/lesson/circuit/coat.mp3")]
		private static var CircuitCoat:Class;
		[Embed(source = "../../../../audio/lesson/circuit/far.mp3")]
		private static var CircuitFar:Class;
		[Embed(source = "../../../../audio/lesson/circuit/for.mp3")]
		private static var CircuitFor:Class;
		[Embed(source = "../../../../audio/lesson/circuit/form.mp3")]
		private static var CircuitForm:Class;
		[Embed(source = "../../../../audio/lesson/circuit/fort.mp3")]
		private static var CircuitFort:Class;
		[Embed(source = "../../../../audio/lesson/circuit/hand.mp3")]
		private static var CircuitHand:Class;
		[Embed(source = "../../../../audio/lesson/circuit/hat.mp3")]
		private static var CircuitHat:Class;
		[Embed(source = "../../../../audio/lesson/circuit/horn.mp3")]
		private static var CircuitHorn:Class;
		[Embed(source = "../../../../audio/lesson/circuit/march.mp3")]
		private static var CircuitMarch:Class;
		[Embed(source = "../../../../audio/lesson/circuit/score.mp3")]
		private static var CircuitScore:Class;
		[Embed(source = "../../../../audio/lesson/circuit/share.mp3")]
		private static var CircuitShare:Class;
		[Embed(source = "../../../../audio/lesson/circuit/sharp.mp3")]
		private static var CircuitSharp:Class;
		[Embed(source = "../../../../audio/lesson/circuit/short.mp3")]
		private static var CircuitShort:Class;
		[Embed(source = "../../../../audio/lesson/circuit/show.mp3")]
		private static var CircuitShow:Class;
		[Embed(source = "../../../../audio/lesson/circuit/snow.mp3")]
		private static var CircuitSnow:Class;
		[Embed(source = "../../../../audio/lesson/circuit/star.mp3")]
		private static var CircuitStar:Class;
		[Embed(source = "../../../../audio/lesson/circuit/storm.mp3")]
		private static var CircuitStorm:Class;
		[Embed(source = "../../../../audio/lesson/circuit/torn.mp3")]
		private static var CircuitTorn:Class;
		public static var CircuitSound:Object = { _bar:CircuitBar, _bark:CircuitBark, _boat:CircuitBoat, _bow:CircuitBow,
			_coat:CircuitCoat, _far:CircuitFar, _for:CircuitFor, _form:CircuitForm, _fort:CircuitFort, _hand:CircuitHand,
			_hat:CircuitHat, _horn:CircuitHorn, _march:CircuitMarch, _score:CircuitScore, _share:CircuitShare, _sharp:CircuitSharp,
			_short:CircuitShort, _show:CircuitShow, _snow:CircuitSnow, _star:CircuitStar, _storm:CircuitStorm, _torn:CircuitTorn };
		
		[Embed(source = "../../../../audio/lesson/hubInstruction.mp3")]
		public static var HUBInstructionSound:Class;
		[Embed(source = "../../../../audio/lesson/spotlightInstruction.mp3")]
		public static var SpotlightInstructionSound:Class;
		[Embed(source = "../../../../audio/lesson/flashlightInstruction.mp3")]
		public static var FlashlightInstructionSound:Class;
		[Embed(source = "../../../../audio/lesson/circuitInstruction.mp3")]
		public static var CircuitInstructionSound:Class;
		[Embed(source = "../../../../audio/lesson/familyInstruction.mp3")]
		public static var FamilyInstructionSound:Class;
		
		[Embed(source = "../../../../audio/lesson/spotlightTitle.mp3")]
		public static var SpotlightTitleSound:Class;
		[Embed(source = "../../../../audio/lesson/flashlightTitle.mp3")]
		public static var FlashlightTitleSound:Class;
		[Embed(source = "../../../../audio/lesson/circuitTitle.mp3")]
		public static var CircuitTitleSound:Class;
		[Embed(source = "../../../../audio/lesson/familyTitle.mp3")]
		public static var FamilySortTitleSound:Class;
		
		[Embed(source = "../../../../audio/lesson/family/ow.mp3")]
		private static var Ow:Class;
		[Embed(source = "../../../../audio/lesson/family/oat.mp3")]
		private static var Oat:Class;
		[Embed(source = "../../../../audio/lesson/family/orch.mp3")]
		private static var Orch:Class;
		[Embed(source = "../../../../audio/lesson/family/ar.mp3")]
		private static var Ar:Class;
		public static var FamilySound:Object = { _ow:Ow, _oat:Oat, _orch:Orch, _ar:Ar };
		
		[Embed(source = "../../../../audio/lesson/family/snow.mp3")]
		private static var Snow:Class;
		[Embed(source = "../../../../audio/lesson/family/goat.mp3")]
		private static var Goat:Class;
		[Embed(source = "../../../../audio/lesson/family/scorch.mp3")]
		private static var Scorch:Class;
		[Embed(source = "../../../../audio/lesson/family/far.mp3")]
		private static var Far:Class;
		public static var FamilyExampleSound:Object = { _snow:Snow, _goat:Goat, _scorch:Scorch, _far:Far };
		
		[Embed(source = "../../../../audio/lesson/family/low.mp3")]
		private static var Low:Class;
		[Embed(source = "../../../../audio/lesson/family/glow.mp3")]
		private static var Glow:Class;
		[Embed(source = "../../../../audio/lesson/family/coat.mp3")]
		private static var Coat:Class;
		[Embed(source = "../../../../audio/lesson/family/boat.mp3")]
		private static var Boat:Class;
		[Embed(source = "../../../../audio/lesson/family/torch.mp3")]
		private static var Torch:Class;
		[Embed(source = "../../../../audio/lesson/family/porch.mp3")]
		private static var Porch:Class;
		[Embed(source = "../../../../audio/lesson/family/star.mp3")]
		private static var Star:Class;
		[Embed(source = "../../../../audio/lesson/family/jar.mp3")]
		private static var Jar:Class;
		public static var FamilyWordSound:Object = { _low:Low, _glow:Glow, _coat:Coat, _boat:Boat,
			_torch:Torch, _porch:Porch, _star:Star, _jar:Jar };
		
		[Embed(source = "../../../../audio/pieceExplosion.mp3")]
		public static var PieceExplosionSound:Class;
		[Embed(source = "../../../../audio/trayExplosion.mp3")]
		public static var TrayExplosionSound:Class;
		
		[Embed(source = "../../../../font/sweater school rg.otf", fontName = "SweaterSchoolRg-Regular",
			mimeType = "application/x-font", fontWeight = "normal", fontStyle = "normal", embedAsCFF = "false")]
		private static var SweaterSchool:Class;
		public static var SweaterSchoolFont:Font = new SweaterSchool();
		
		[Embed(source = "../../../../font/sweater school sb.otf", fontName = "SweaterSchoolSb-Regular",
			mimeType = "application/x-font", fontWeight = "normal", fontStyle = "normal", embedAsCFF = "false")]
		public static var SweaterSchoolSemiBold:Class;
		public static var SweaterSchoolSemiBoldFont:Font = new SweaterSchoolSemiBold();
		
		[Embed(source = "../../../../font/sweater school bd.otf", fontName = "SweaterSchoolRg-Bold",
			mimeType = "application/x-font", fontWeight = "bold", fontStyle = "normal", embedAsCFF = "false")]
		private static var SweaterSchoolBold:Class;
		public static var SweaterSchoolBoldFont:Font = new SweaterSchoolBold();
		
		[Embed(source = "../../../../font/sweater school xb.otf", fontName = "SweaterSchoolXb-Regular",
			mimeType = "application/x-font", fontWeight = "normal", fontStyle = "normal", embedAsCFF = "false")]
		private static var SweaterSchoolExtraBold:Class;
		public static var SweaterSchoolExtraBoldFont:Font = new SweaterSchoolExtraBold();
		
		public function Asset()
		{
			throw new Error("Asset is static and not intended for instantiation!");
		}
	}
}