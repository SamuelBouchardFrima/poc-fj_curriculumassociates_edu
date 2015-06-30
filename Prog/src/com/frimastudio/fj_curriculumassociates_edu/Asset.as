package com.frimastudio.fj_curriculumassociates_edu
{
	import flash.display.MovieClip;
	import flash.text.Font;
	
	public class Asset
	{
		[Embed(source = "../../../../art/POC/background/CA_BG_LabGreen_V3.jpg")]
		public static var TheLabBGBitmap:Class;
		[Embed(source = "../../../../art/POC/background/CA_BG_Townsquare_V4.jpg")]
		public static var TownSquareBGBitmap:Class;
		[Embed(source = "../../../../art/POC/background/CA_BG_Grocery_Store_V2.jpg")]
		public static var GroceryStoreBGBitmap:Class;
		[Embed(source = "../../../../art/POC/background/CA_BG_Stage_Rock_V3.jpg")]
		public static var TheaterBGBitmap:Class;
		
		[Embed(source = "../../../../art/POC/lucu/Persos.png")]
		public static var LucuDuoBitmap:Class;
		
		[Embed(source = "../../../../art/POC/npc/CA_NPC_Cop_V1.png")]
		public static var CopNPCBitmap:Class;
		[Embed(source = "../../../../art/POC/npc/CA_NPC_Chef_V2.png")]
		public static var ChefNPCBitmap:Class;
		[Embed(source = "../../../../art/POC/npc/CA_NPC_GlamStar_V3.png")]
		public static var GlamStarNPCBitmap:Class;
		
		[Embed(source = "../../../../art/POC/prop/Chair.png")]
		public static var ChairPropBitmap:Class;
		[Embed(source = "../../../../art/POC/prop/Rat.png")]
		public static var RatPropBitmap:Class;
		
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
		
		[Embed(source = "../../../../art/POC/UnlockPopup.png")]
		public static var UnlockPopupBitmap:Class;
		[Embed(source = "../../../../art/POC/Fliers.png")]
		public static var FliersBitmap:Class;
		
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
		[Embed(source = "../../../../audio/fusion.mp3")]
		public static var FusionSound:Class;
		[Embed(source = "../../../../audio/burp.mp3")]
		public static var BurpSound:Class;
		
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
		
		[Embed(source = "../../../../audio/letters/new/h.mp3")]
		private static var H:Class;
		[Embed(source = "../../../../audio/letters/new/i.mp3")]
		private static var I:Class;
		[Embed(source = "../../../../audio/letters/new/l.mp3")]
		private static var L:Class;
		[Embed(source = "../../../../audio/letters/new/f.mp3")]
		private static var F:Class;
		[Embed(source = "../../../../audio/letters/new/e.mp3")]
		private static var E:Class;
		[Embed(source = "../../../../audio/letters/new/t.mp3")]
		private static var T:Class;
		[Embed(source = "../../../../audio/letters/new/a.mp3")]
		private static var A:Class;
		[Embed(source = "../../../../audio/letters/new/c.mp3")]
		private static var C:Class;
		[Embed(source = "../../../../audio/letters/new/m.mp3")]
		private static var M:Class;
		[Embed(source = "../../../../audio/letters/new/s.mp3")]
		private static var S:Class;
		[Embed(source = "../../../../audio/letters/new/u.mp3")]
		private static var U:Class;
		[Embed(source = "../../../../audio/letters/new/r.mp3")]
		private static var R:Class;
		[Embed(source = "../../../../audio/letters/new/p.mp3")]
		private static var P:Class;
		[Embed(source = "../../../../audio/letters/new/o.mp3")]
		private static var O:Class;
		[Embed(source = "../../../../audio/letters/new/g.mp3")]
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
		
		[Embed(source = "../../../../audio/game/dialog_1-1.mp3")]
		private static var Dialog1_1:Class;
		[Embed(source = "../../../../audio/game/dialog_1-2.mp3")]
		private static var Dialog1_2:Class;
		[Embed(source = "../../../../audio/game/dialog_1-3.mp3")]
		private static var Dialog1_3:Class;
		[Embed(source = "../../../../audio/game/dialog_2-1.mp3")]
		private static var Dialog2_1:Class;
		[Embed(source = "../../../../audio/game/dialog_2-2.mp3")]
		private static var Dialog2_2:Class;
		[Embed(source = "../../../../audio/game/dialog_2-3.mp3")]
		private static var Dialog2_3:Class;
		[Embed(source = "../../../../audio/game/dialog_3-1.mp3")]
		private static var Dialog3_1:Class;
		[Embed(source = "../../../../audio/game/dialog_3-2.mp3")]
		private static var Dialog3_2:Class;
		[Embed(source = "../../../../audio/game/dialog_4-1.mp3")]
		private static var Dialog4_1:Class;
		[Embed(source = "../../../../audio/game/dialog_4-2.mp3")]
		private static var Dialog4_2:Class;
		public static var DialogSound:Object = [ Dialog1_1, Dialog1_2, Dialog1_3, Dialog2_1, Dialog2_2, Dialog2_3,
			Dialog3_1, Dialog3_2, Dialog4_1, Dialog4_2 ];
		
		[Embed(source = "../../../../audio/POC Audio/Game Hints/01_great_job.mp3")]
		private static var GameHint_01_great_job:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/02_karaoke_contest.mp3")]
		private static var GameHint_02_karaoke_contest:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/03_where_start.mp3")]
		private static var GameHint_03_where_start:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/04_click_letters_word_parts.mp3")]
		private static var GameHint_04_click_letters_word_parts:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/05_word_Mini.mp3")]
		private static var GameHint_05_word_Mini:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/06_more_words.mp3")]
		private static var GameHint_06_more_words:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/07_click_get_words.mp3")]
		private static var GameHint_07_click_get_words:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/08_fliers_in_town.mp3")]
		private static var GameHint_08_fliers_in_town:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/09_flier_citizen.mp3")]
		private static var GameHint_09_flier_citizen:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/10_click_sentence.mp3")]
		private static var GameHint_10_click_sentence:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/11_more_people_theater.mp3")]
		private static var GameHint_11_more_people_theater:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/12_running_out_words.mp3")]
		private static var GameHint_12_running_out_words:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/13_something_room_help.mp3")]
		private static var GameHint_13_something_room_help:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/14_put_words_order.mp3")]
		private static var GameHint_14_put_words_order:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/15_ready_karaoke_contest.mp3")]
		private static var GameHint_15_ready_karaoke_contest:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/16_back_to_lab.mp3")]
		private static var GameHint_16_back_to_lab:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/17_write_song.mp3")]
		private static var GameHint_17_write_song:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/18_original.mp3")]
		private static var GameHint_18_original:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/19_let_me_try.mp3")]
		private static var GameHint_19_let_me_try:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/20_working_song.mp3")]
		private static var GameHint_20_working_song:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/21_sounds_great.mp3")]
		private static var GameHint_21_sounds_great:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/22_monkey_buzzard_salamander.mp3")]
		private static var GameHint_22_monkey_buzzard_salamander:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/23_mommas_soup.mp3")]
		private static var GameHint_23_mommas_soup:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/24_rockin_tune_ready.mp3")]
		private static var GameHint_24_rockin_tune_ready:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/25_click_word.mp3")]
		private static var GameHint_25_click_word:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/26_click_scrambled.mp3")]
		private static var GameHint_26_click_scrambled:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/27_unscramble_letters.mp3")]
		private static var GameHint_27_unscramble_letters:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/28_dont_sing.mp3")]
		private static var GameHint_28_dont_sing:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/29_look_at.mp3")]
		private static var GameHint_29_look_at:Class;
		[Embed(source = "../../../../audio/POC Audio/Game Hints/30_mix_it_up.mp3")]
		private static var GameHint_30_mix_it_up:Class;
		public static var GameHintSound:Object = [null, GameHint_01_great_job, GameHint_02_karaoke_contest, GameHint_03_where_start,
			GameHint_04_click_letters_word_parts, GameHint_05_word_Mini, GameHint_06_more_words, GameHint_07_click_get_words,
			GameHint_08_fliers_in_town, GameHint_09_flier_citizen, GameHint_10_click_sentence, GameHint_11_more_people_theater,
			GameHint_12_running_out_words, GameHint_13_something_room_help, GameHint_14_put_words_order,
			GameHint_15_ready_karaoke_contest, GameHint_16_back_to_lab, GameHint_17_write_song, GameHint_18_original,
			GameHint_19_let_me_try, GameHint_20_working_song, GameHint_21_sounds_great, GameHint_22_monkey_buzzard_salamander,
			GameHint_23_mommas_soup, GameHint_24_rockin_tune_ready, GameHint_25_click_word, GameHint_26_click_scrambled,
			GameHint_27_unscramble_letters, GameHint_28_dont_sing, GameHint_29_look_at, GameHint_30_mix_it_up];
		
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/01_t_.mp3")]
		private static var LetterSound_01_t_:Class;
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/02-1_i_short.mp3")]
		private static var LetterSound_02_1_i_short:Class;
		//[Embed(source = "../../../../audio/POC Audio/Letter Sounds/02-2_i_long.mp3")]
		//private static var LetterSound_02_2_i_long:Class;
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/03_p_.mp3")]
		private static var LetterSound_03_p_:Class;
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/04_r_.mp3")]
		private static var LetterSound_04_r_:Class;
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/05_n_.mp3")]
		private static var LetterSound_05_n_:Class;
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/06_d_.mp3")]
		private static var LetterSound_06_d_:Class;
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/07_m_.mp3")]
		private static var LetterSound_07_m_:Class;
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/08_f_.mp3")]
		private static var LetterSound_08_f_:Class;
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/09_s_.mp3")]
		private static var LetterSound_09_s_:Class;
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/10-1_a_short.mp3")]
		private static var LetterSound_10_1_a_short:Class;
		[Embed(source = "../../../../audio/POC Audio/Letter Sounds/10-2_a_long.mp3")]
		private static var LetterSound_10_2_a_long:Class;
		//public static var LetterAudioSound:Object = [null, LetterSound_01_t_, LetterSound_02_1_i_short, LetterSound_03_p_,
			//LetterSound_04_r_, LetterSound_05_n_, LetterSound_06_d_, LetterSound_07_m_, LetterSound_08_f_, LetterSound_09_s_,
			//LetterSound_10_1_a_short];
		public static var LetterAudioSound:Object = { _t:LetterSound_01_t_, _i:LetterSound_02_1_i_short, _p:LetterSound_03_p_,
			_r:LetterSound_04_r_, _n:LetterSound_05_n_, _d:LetterSound_06_d_, _m:LetterSound_07_m_, _f:LetterSound_08_f_,
			_s:LetterSound_09_s_, _a:LetterSound_10_1_a_short };
		
		[Embed(source = "../../../../audio/POC Audio/Other/choose_location.mp3")]
		private static var Navigation_choose_location:Class;
		[Embed(source = "../../../../audio/POC Audio/Other/a_lab.mp3")]
		private static var Navigation_a_lab:Class;
		[Embed(source = "../../../../audio/POC Audio/Other/b_town_square.mp3")]
		private static var Navigation_b_town_square:Class;
		[Embed(source = "../../../../audio/POC Audio/Other/c_grocery_store.mp3")]
		private static var Navigation_c_grocery_store:Class;
		[Embed(source = "../../../../audio/POC Audio/Other/d_theater.mp3")]
		private static var Navigation_d_theater:Class;
		public static var NavigationSound:Object = [Navigation_choose_location, Navigation_a_lab, Navigation_b_town_square,
			Navigation_c_grocery_store, Navigation_d_theater];
		
		[Embed(source = "../../../../audio/POC Audio/Rewards/01_did_lesson_13.mp3")]
		private static var Reward_01_did_lesson_13:Class;
		[Embed(source = "../../../../audio/POC Audio/Rewards/02_lesson_reward.mp3")]
		private static var Reward_02_lesson_reward:Class;
		[Embed(source = "../../../../audio/POC Audio/Rewards/03_quest_reward.mp3")]
		private static var Reward_03_quest_reward:Class;
		[Embed(source = "../../../../audio/POC Audio/Rewards/04_pattern_cards.mp3")]
		private static var Reward_04_pattern_cards:Class;
		[Embed(source = "../../../../audio/POC Audio/Rewards/05_words.mp3")]
		private static var Reward_05_words:Class;
		[Embed(source = "../../../../audio/POC Audio/Rewards/06_have_fliers.mp3")]
		private static var Reward_06_have_fliers:Class;
		[Embed(source = "../../../../audio/POC Audio/Rewards/07_grocery_unlocked.mp3")]
		private static var Reward_07_grocery_unlocked:Class;
		[Embed(source = "../../../../audio/POC Audio/Rewards/08_square_unlocked.mp3")]
		private static var Reward_08_square_unlocked:Class;
		[Embed(source = "../../../../audio/POC Audio/Rewards/09_theater_unlocked.mp3")]
		private static var Reward_09_theater_unlocked:Class;
		[Embed(source = "../../../../audio/POC Audio/Rewards/10_unlocked_karaoke.mp3")]
		private static var Reward_10_unlocked_karaoke:Class;
		public static var RewardSound:Object = [null, Reward_01_did_lesson_13, Reward_02_lesson_reward, Reward_03_quest_reward,
			Reward_04_pattern_cards, Reward_05_words, Reward_06_have_fliers, Reward_07_grocery_unlocked, Reward_08_square_unlocked,
			Reward_09_theater_unlocked, Reward_10_unlocked_karaoke];
		
		[Embed(source = "../../../../audio/POC Audio/Sentence_Content_Target/01_print_fliers.mp3")]
		private static var SentenceContentTarget_01_print_fliers:Class;
		[Embed(source = "../../../../audio/POC Audio/Sentence_Content_Target/02_sit_on_it.mp3")]
		private static var SentenceContentTarget_02_sit_on_it:Class;
		[Embed(source = "../../../../audio/POC Audio/Sentence_Content_Target/03_watch_sit_front.mp3")]
		private static var SentenceContentTarget_03_watch_sit_front:Class;
		[Embed(source = "../../../../audio/POC Audio/Sentence_Content_Target/04_love_sing.mp3")]
		private static var SentenceContentTarget_04_love_sing:Class;
		[Embed(source = "../../../../audio/POC Audio/Sentence_Content_Target/05_dont_sing_can_rap.mp3")]
		private static var SentenceContentTarget_05_dont_sing_can_rap:Class;
		[Embed(source = "../../../../audio/POC Audio/Sentence_Content_Target/06_look_fat_rat.mp3")]
		private static var SentenceContentTarget_06_look_fat_rat:Class;
		[Embed(source = "../../../../audio/POC Audio/Sentence_Content_Target/07_lip_hip_eyes.mp3")]
		private static var SentenceContentTarget_07_lip_hip_eyes:Class;
		[Embed(source = "../../../../audio/POC Audio/Sentence_Content_Target/08_mix_it_take_sip.mp3")]
		private static var SentenceContentTarget_08_mix_it_take_sip:Class;
		public static var SentenceContentTargetSound:Object = [null, SentenceContentTarget_01_print_fliers,
			SentenceContentTarget_02_sit_on_it, SentenceContentTarget_03_watch_sit_front, SentenceContentTarget_04_love_sing,
			SentenceContentTarget_05_dont_sing_can_rap, SentenceContentTarget_06_look_fat_rat,
			SentenceContentTarget_07_lip_hip_eyes, SentenceContentTarget_08_mix_it_take_sip];
		
		[Embed(source = "../../../../audio/POC Audio/Word_Content/01_tip.mp3")]
		private static var WordContent_01_tip:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/02_rip.mp3")]
		private static var WordContent_02_rip:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/03_nip.mp3")]
		private static var WordContent_03_nip:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/04_dim.mp3")]
		private static var WordContent_04_dim:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/05_fin.mp3")]
		private static var WordContent_05_fin:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/06_sit.mp3")]
		private static var WordContent_06_sit:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/07_pit.mp3")]
		private static var WordContent_07_pit:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/08_sip.mp3")]
		private static var WordContent_08_sip:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/09_it.mp3")]
		private static var WordContent_09_it:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/10_if.mp3")]
		private static var WordContent_10_if:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/11_in.mp3")]
		private static var WordContent_11_in:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/12_rid.mp3")]
		private static var WordContent_12_rid:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/13_to.mp3")]
		private static var WordContent_13_to:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/14_did.mp3")]
		private static var WordContent_14_did:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/15_look.mp3")]
		private static var WordContent_15_look:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/16_at.mp3")]
		private static var WordContent_16_at:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/17_the.mp3")]
		private static var WordContent_17_the:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/18_fat.mp3")]
		private static var WordContent_18_fat:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/19_rat.mp3")]
		private static var WordContent_19_rat:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/20_i.mp3")]
		private static var WordContent_20_i:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/21_dont.mp3")]
		private static var WordContent_21_dont:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/22_sing.mp3")]
		private static var WordContent_22_sing:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/23_but.mp3")]
		private static var WordContent_23_but:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/24_can.mp3")]
		private static var WordContent_24_can:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/25_rap.mp3")]
		private static var WordContent_25_rap:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/26_fit.mp3")]
		private static var WordContent_26_fit:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/27_mix.mp3")]
		private static var WordContent_27_mix:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/28_up.mp3")]
		private static var WordContent_28_up:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/29_and.mp3")]
		private static var WordContent_29_and:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/30_take.mp3")]
		private static var WordContent_30_take:Class;
		//[Embed(source = "../../../../audio/POC Audio/Word_Content/31-1_a_ah.mp3")]
		//private static var WordContent_31_1_a_ah:Class;
		//[Embed(source = "../../../../audio/POC Audio/Word_Content/31-2_a_ay.mp3")]
		//private static var WordContent_31_2_a_ay:Class;
		[Embed(source = "../../../../audio/POC Audio/Word_Content/31-3_a_uh.mp3")]
		private static var WordContent_31_3_a_uh:Class;
		public static var WordContentSound:Object = { _tip:WordContent_01_tip, _rip:WordContent_02_rip, _nip:WordContent_03_nip,
			_dim:WordContent_04_dim, _fin:WordContent_05_fin, _sit:WordContent_06_sit, _pit:WordContent_07_pit,
			_sip:WordContent_08_sip, _it:WordContent_09_it, _if:WordContent_10_if, _in:WordContent_11_in, _rid:WordContent_12_rid,
			_to:WordContent_13_to, _did:WordContent_14_did, _look:WordContent_15_look, _at:WordContent_16_at,
			_the:WordContent_17_the, _fat:WordContent_18_fat, _rat:WordContent_19_rat, _i:WordContent_20_i,
			_dont:WordContent_21_dont, _sing:WordContent_22_sing, _but:WordContent_23_but, _can:WordContent_24_can,
			_rap:WordContent_25_rap, _fit:WordContent_26_fit, _mix:WordContent_27_mix, _up:WordContent_28_up,
			_and:WordContent_29_and, _take:WordContent_30_take, _a:WordContent_31_3_a_uh };
		
		[Embed(source = "../../../../audio/game/whereIsTheField.mp3")]
		public static var WhereIsTheFieldSound:Class;
		
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