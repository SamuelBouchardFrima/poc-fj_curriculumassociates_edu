package com.frimastudio.fj_curriculumassociates_edu.lucutaming
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBox;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dictionary.LetterDistribution;
	import com.frimastudio.fj_curriculumassociates_edu.dictionary.WordDictionary;
	import com.frimastudio.fj_curriculumassociates_edu.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.Piece;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.MathUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.MouseUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	public class LucuTaming extends Activity
	{
		private static const TARGET_WORD_LIST:Vector.<String> = new <String>["tip", "rip", "nip", "dim", "fin", "sit", "pit", "sip", "rid", "did", "fit"];
		private static const TARGET_RHYME_LIST:Vector.<String> = new <String>["ip", "im", "in", "it", "id"];
		//private static const TARGET_ALLITERATION_LIST:Vector.<String> = new <String>["ti", "ri", "ni", "di", "fi", "si", "pi"];
		private static const TARGET_ALLITERATION_LIST:Vector.<String> = new <String>["ri", "ni", "di", "fi", "si", "pi"];
		
		private var mTemplate:LucuTamingTemplate;
		private var mToolTrayBox:Box;
		private var mDialogBox:CurvedBox;
		private var mActivityBox:ActivityBox;
		private var mBurpTimer:Timer;
		private var mMouthPosition:Point;
		private var mFloatPieceList:Vector.<Piece>;
		private var mFloatPieceArea:Rectangle;
		private var mToolTray:PieceTray;
		private var mStartCount:int;
		private var mStarCountTxt:TextField;
		//private var mCraftingElement:Sprite;
		private var mCraftingArea:CurvedBox;
		private var mCraftingTray:PieceTray;
		private var mSubmitBtn:CurvedBox;
		private var mEarTargetWordTimer:Timer;
		private var mSubmission:String;
		private var mTargetWord:String;
		private var mTargetWordList:Vector.<String>;
		private var mTargetRhyme:String;
		private var mTargetAlliteration:String;
		private var mCompletedWordList:Vector.<String>;
		private var mDraggedPiece:Piece;
		private var mBurpDone:Boolean;
		private var mStringType:StringType;
		
		public function LucuTaming(aTemplate:LucuTamingTemplate)
		{
			super(aTemplate);
			
			mSubmission = "";
			
			mTemplate = aTemplate;
			
			mStringType = StringType.RandomType;
			
			mToolTrayBox = new Box(new Point(1024, 130), Palette.TOOL_BOX);
			mToolTrayBox.x = 512;
			mToolTrayBox.y = 838;
			addChild(mToolTrayBox);
			TweenLite.to(mToolTrayBox, 1.2, {ease: Elastic.easeOut, y: 753});
			
			var playerPortrait:Sprite = new Sprite();
			var playerPortraitBitmap:Bitmap = new Asset.PlayerPortrait() as Bitmap;
			playerPortraitBitmap.smoothing = true;
			playerPortraitBitmap.scaleX = playerPortraitBitmap.scaleY = 0.75;
			playerPortraitBitmap.x = -playerPortraitBitmap.width / 2;
			playerPortraitBitmap.y = -playerPortraitBitmap.height / 2;
			playerPortrait.addChild(playerPortraitBitmap);
			playerPortrait.x = 5 + (playerPortrait.width / 2);
			playerPortrait.y = 763 - (playerPortrait.height / 2);
			addChild(playerPortrait);
			
			//mToolTray = new PieceTray(false, new <String>["___", "___", "___"]);
			mToolTray = new PieceTray(false);
			//mToolTray.BoxColor = 0xD18B25;
			mToolTray.BoxColor = 0xCCCCCC;
			mToolTray.x = playerPortrait.x + (playerPortrait.width / 2) + 15;
			mToolTray.y = 813;
			addChild(mToolTray);
			TweenLite.to(mToolTray, 1.2, {ease: Elastic.easeOut, delay: 0.1, y: 728});
			
			mMouthPosition = new Point(512 - 10, 384 - 5);
			
			var instruction:String = "";
			switch (mStringType)
			{
				case StringType.WORD:
					mTargetWordList = new Vector.<String>();
					var i:int, endi:int;
					var j:int, endj:int;
					for (i = 0, endi = TARGET_WORD_LIST.length; i < endi; ++i)
					{
						for (j = 0, endj = Inventory.SelectedLetterPatternCardList.length; j < endj; ++j)
						{
							if (TARGET_WORD_LIST[i].indexOf(Inventory.SelectedLetterPatternCardList[j]) > -1)
							{
								mTargetWordList.push(TARGET_WORD_LIST[i]);
								break;
							}
						}
					}
					instruction = "Craft the requested words as fast as you can.";
					break;
				case StringType.RHYME:
					//mTargetRhyme = Random.FromList(TARGET_RHYME_LIST);
					mTargetRhyme = Random.FromList(Inventory.SelectedLetterPatternCardList);
					instruction = "Craft words that rhyme with \"" + mTargetRhyme + "\" as fast as you can.";
					break;
				case StringType.ALLITERATION:
					mTargetAlliteration = Random.FromList(TARGET_ALLITERATION_LIST);
					instruction = "Craft words that start like \"" + mTargetAlliteration + "\" as fast as you can.";
					break;
				default:
					throw new Error("StringType " + mStringType.Description + " unhandled.");
					break;
			}
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX,
				new BoxLabel(instruction, 45, Palette.DIALOG_CONTENT), 6, Direction.UP_LEFT, Axis.BOTH);
			mDialogBox.x = mTemplate.CurrentLevel.Lucu.x - (mTemplate.CurrentLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = Math.min(mTemplate.CurrentLevel.Lucu.y + (mTemplate.CurrentLevel.Lucu.height / 2) + 10 +
				(mDialogBox.height / 2), 668 - (mDialogBox.height / 2));
			addChild(mDialogBox);
			
			LucuTamingEnergy.Instance.Discharge();
			
			InitializeMap();
			
			mWildLucu = new Sprite();
			SetWildLucu(Asset.WildLucuIdleBitmap);
			mWildLucu.x = 1024 - 10 - (mWildLucu.width / 2);
			mWildLucu.y = mMap.y - (mMap.height / 2) - 10 - (mWildLucu.height / 2);
			addChild(mWildLucu);
			TweenLite.to(mWildLucu, 1, { ease:Strong.easeInOut, x:512, y:(384 - 5), onComplete:OnTweenMoveLucuUp });
			
			mActivityBox = new ActivityBox(new Vector.<WordTemplate>(), new Vector.<int>(), null, Direction.DOWN);
			mActivityBox.x = 512;
			mActivityBox.y = 70;
			addChild(mActivityBox);
			
			var star:Bitmap = new Asset.CircuitBitmap["_star"]() as Bitmap;
			star.smoothing = true;
			star.x = 10;
			star.y = 10;
			star.scaleX = star.scaleY = 0.6;
			addChild(star);
			
			mStartCount = 0;
			
			mStarCountTxt = new TextField();
			mStarCountTxt.embedFonts = true;
			mStarCountTxt.x = 15;
			mStarCountTxt.y = 47;
			mStarCountTxt.autoSize = TextFieldAutoSize.CENTER;
			addChild(mStarCountTxt);
			UpdateStarCount();
			
			//mTargetWord = Random.FromList(TARGET_WORD_LIST);
			//mTargetWord = Random.FromList(mTargetWordList);
			//mTargetWordList.splice(mTargetWordList.indexOf(mTargetWord), 1);
			//SoundManager.PlaySFX(Asset.WordContentSound["_" + mTargetWord]);
			
			mEarTargetWordTimer = new Timer(6000);
			mEarTargetWordTimer.addEventListener(TimerEvent.TIMER, OnEarTargetWordTimer);
			//mEarTargetWordTimer.start();
			
			mCompletedWordList = new Vector.<String>();
			
			//mCraftingElement = new Sprite();
			//mCraftingElement.x = 512;
			//mCraftingElement.y = 70;
			//addChild(mCraftingElement);
			
			mCraftingArea = new CurvedBox(new Point(500, 80), 0x999999);
			mCraftingArea.x = 512;
			mCraftingArea.y = 70;
			//mCraftingElement.addChild(mCraftingArea);
			addChild(mCraftingArea);
			
			//mCraftingTray = new PieceTray(false, new <String>["___"]);
			mCraftingTray = new PieceTray(false);
			mCraftingTray.BoxColor = ActivityType.WORD_CRAFTING.ColorCode;
			//mCraftingTray.x = 40;
			//mCraftingTray.x = star.x + star.width;
			mCraftingTray.x = 512 - (mCraftingArea.width / 2) + 10;
			//mCraftingTray.y = 70;
			mCraftingTray.y = 70;
			//mCraftingElement.addChild(mCraftingTray);
			mCraftingTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnCraftingTrayPieceFreed);
			addChild(mCraftingTray);
			
			//mCraftingArea.Size = new Point(mCraftingTray.Bounds.width + 20, mCraftingArea.Size.y);
			
			mSubmitBtn = new CurvedBox(new Point(64, 64), Palette.GREAT_BTN, new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 6);
			//var contentWidth:Number = mCraftingTray.Bounds.width + 20 + mSubmitBtn.width;
			//mSubmitBtn.x = (contentWidth / 2) - (mSubmitBtn.width / 2);
			//mSubmitBtn.x = (mCraftingArea.width / 2) - (mSubmitBtn.width / 2) - 10;
			mSubmitBtn.x = 512 + (mCraftingArea.width / 2) - (mSubmitBtn.width / 2) - 10;
			//mSubmitBtn.y = 0;
			mSubmitBtn.y = 70;
			mSubmitBtn.addEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			//mCraftingElement.addChild(mSubmitBtn);
			addChild(mSubmitBtn);
			
			//mCraftingTray.x = -(contentWidth / 2);
			//mCraftingArea.Size = new Point(contentWidth + 20, mCraftingArea.Size.y);
			
			var openMouthTimer:Timer = new Timer(1000, 1);
			openMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnOpenMouthTimerComplete);
			openMouthTimer.start();
			
			var card:CurvedBox;
			var uiCard:CurvedBox;
			for (i = 0, endi = Inventory.SelectedLetterPatternCardList.length; i < endi; ++i)
			{
				card = new CurvedBox(new Point(64, 64), 0xCC99FF,
					new BoxLabel(Inventory.SelectedLetterPatternCardList[i], 48, Palette.DIALOG_CONTENT), 6, null, Axis.HORIZONTAL);
				card.ColorBorderOnly = true;
				DisplayObjectUtil.SetPosition(card, DisplayObjectUtil.GetPosition(playerPortrait));
				card.alpha = 0;
				card.scaleX = card.scaleY = 0.01;
				addChild(card);
				TweenLite.to(card, 0.4, { ease:Strong.easeOut, delay:((i * 0.8) + 1), alpha:1, scaleX:1, scaleY:1});
				TweenLite.to(card, 0.6, { ease:Strong.easeOut, delay:((i * 0.8) + 1.2), onComplete:OnTweenSendCard, onCompleteParams:[card], x:mMouthPosition.x, y:mMouthPosition.y } );
				
				uiCard = new CurvedBox(new Point(64, 64), 0xCC99FF,
					new BoxLabel(Inventory.SelectedLetterPatternCardList[i], 48, Palette.DIALOG_CONTENT), 6, null, Axis.HORIZONTAL);
				uiCard.ColorBorderOnly = true;
				uiCard.x = -(uiCard.width / 2) - 10;
				uiCard.y = 10 + mActivityBox.height + (i * 74);
				addChild(uiCard);
				TweenLite.to(uiCard, 1, { ease:Elastic.easeOut, delay:((i * 0.1) + 0.5), x:((uiCard.width / 2) + 10) });
			}
			
			var swallowDuration:Number = ((Inventory.SelectedLetterPatternCardList.length * 0.8) + 0.5) * 1000;
			
			var closeMouthTimer:Timer = new Timer(swallowDuration, 2);
			closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
			closeMouthTimer.start();
			
			var startBurpTimerTimer:Timer = new Timer(swallowDuration + 800, 1);
			startBurpTimerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnStartBurpTimerTimerComplete);
			startBurpTimerTimer.start();
			
			mBurpTimer = new Timer(5000, 9);
			mBurpTimer.addEventListener(TimerEvent.TIMER, OnBurpTimer);
			mBurpTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnBurpTimerComplete);
			
			mFloatPieceList = new Vector.<Piece>();
			
			var areaY:Number = 180;
			var areaH:Number = 300;
			mFloatPieceArea = new Rectangle(100, areaY, 824, areaH);
			
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
		}
		
		override public function Dispose():void
		{
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			mActivityBox.Dispose();
			
			mBurpTimer.removeEventListener(TimerEvent.TIMER, OnBurpTimer);
			mBurpTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnBurpTimerComplete);
			mBurpTimer.reset();
			
			mCraftingTray.Dispose();
			mToolTray.Dispose();
			
			mEarTargetWordTimer.removeEventListener(TimerEvent.TIMER, OnEarTargetWordTimer);
			mEarTargetWordTimer.reset();
			
			mSubmitBtn.removeEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			
			for (var i:int = 0, endi:int = mFloatPieceList.length; i < endi; ++i)
			{
				mFloatPieceList[i].removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				mFloatPieceList[i].Dispose();
			}
			
			if (mDraggedPiece)
			{
				mDraggedPiece.Dispose();
			}
			
			super.Dispose();
		}
		
		private function AddStar():void
		{
			++mStartCount;
			UpdateStarCount();
			
			// TODO:	play anim over star
			var highlight:Sprite = new Sprite();
			highlight.mouseEnabled = highlight.mouseChildren = false;
			//highlight.x = chunk.x + word.x + mContent.x;
			highlight.x = 70;
			//highlight.y = chunk.y + word.y + mContent.y;
			highlight.y = 70;
			highlight.scaleX = highlight.scaleY = 0.01;
			highlight.alpha = 0;
			var highlightBitmap:Bitmap = new Asset.SubmissionHighlightBitmap() as Bitmap;
			highlightBitmap.smoothing = true;
			highlightBitmap.x = -highlightBitmap.width / 2;
			highlightBitmap.y = -highlightBitmap.height / 2;
			highlight.addChild(highlightBitmap);
			addChild(highlight);
			
			TweenLite.to(highlight, 0.2, { ease:Strong.easeIn, onComplete:OnTweenShowHighlight, onCompleteParams:[highlight],
				scaleX:1, scaleY:1, alpha:1, rotation:30 });
		}
		
		private function UpdateStarCount():void
		{
			mStarCountTxt.text = mStartCount.toString();
			mStarCountTxt.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 42, Palette.DIALOG_CONTENT, null, null, null, null, null, TextFormatAlign.CENTER));
		}
		
		private function SetWildLucu(aWildLucuAsset:Class):void
		{
			while (mWildLucu.numChildren)
			{
				mWildLucu.removeChildAt(0);
			}
			
			var wildLucuBitmap:Bitmap = new aWildLucuAsset() as Bitmap;
			wildLucuBitmap.smoothing = true;
			wildLucuBitmap.scaleX = -0.5;
			wildLucuBitmap.scaleY = 0.5;
			wildLucuBitmap.x = wildLucuBitmap.width / 2;
			wildLucuBitmap.y = -wildLucuBitmap.height / 2;
			mWildLucu.addChild(wildLucuBitmap);
		}
		
		private function GeneratePieceLabel():String
		{
			var i:int, endi:int;
			var roll:int = Random.RangeInt(1, 10);
			if (roll <= 1)
			{
				switch (mStringType)
				{
					case StringType.WORD:
						for (i = 0, endi = Inventory.SelectedLetterPatternCardList.length; i < endi; ++i)
						{
							if (mTargetWord.indexOf(Inventory.SelectedLetterPatternCardList[i]) > -1)
							{
								return Inventory.SelectedLetterPatternCardList[i];
							}
						}
						break;
					case StringType.RHYME:
						return mTargetRhyme;
					case StringType.ALLITERATION:
						break;
					default:
						throw new Error("StringType " + mStringType.Description + " not handled.");
						break;
				}
			}
			if (roll <= 3)
			{
				return Random.FromList(Inventory.SelectedLetterPatternCardList);
			}
			if (roll <= 6)
			{
				switch (mStringType)
				{
					case StringType.WORD:
						return Random.FromString(mTargetWord);
					case StringType.RHYME:
						return Random.FromString(mTargetRhyme);
					case StringType.ALLITERATION:
						return Random.FromString(mTargetAlliteration);
					default:
						throw new Error("StringType " + mStringType.Description + " not handled.");
						break;
				}
			}
			return LetterDistribution.RandomLetter;
		}
		
		private function OnCraftingTrayPieceFreed(aEvent:PieceTrayEvent):void
		{
			var position:Point = aEvent.EventPiece.Position.clone();
			position = position.add(DisplayObjectUtil.GetPosition(mCraftingTray));
			
			mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, position, ActivityType.WORD_CRAFTING.ColorCode);
			addChild(mDraggedPiece);
			
			mDraggedPiece.Position = MouseUtil.PositionRelativeTo(this);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			//mDraggedPiece.addEventListener(MouseEvent.CLICK, OnClickDraggedPiece);
			
			mCraftingTray.Remove(aEvent.EventPiece);
		}
		
		private function OnMouseMoveStage(aEvent:MouseEvent):void
		{
			mDraggedPiece.Position = MouseUtil.PositionRelativeTo(this);
			
			if (mDraggedPiece.getBounds(this).intersects(mCraftingArea.getBounds(this)))
			{
				mCraftingTray.MakePlace(mDraggedPiece);
			}
			else
			{
				mCraftingTray.FreePlace();
			}
		}
		
		private function OnMouseUpStage(aEvent:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			//mDraggedPiece.removeEventListener(MouseEvent.CLICK, OnClickDraggedPiece);
			
			if (mDraggedPiece.getBounds(this).intersects(mCraftingArea.getBounds(this)))
			{
				mCraftingTray.Insert(mDraggedPiece);
				mCraftingTray.BoxColor = ActivityType.WORD_CRAFTING.ColorCode;
				mDraggedPiece.Dispose();
				removeChild(mDraggedPiece);
			}
			else
			{
				var bubble:Bitmap = new Asset.BubbleBitmap();
				bubble.smoothing = true;
				bubble.width = Math.max(bubble.width, mDraggedPiece.width + 30);
				bubble.scaleY = bubble.scaleX;
				bubble.x = -bubble.width / 2;
				bubble.y = -bubble.height / 2;
				mDraggedPiece.addChild(bubble);
				
				mDraggedPiece.StartDecay(30000);
				mDraggedPiece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
				
				mDraggedPiece.Position = MathUtil.MinMaxPoint(mDraggedPiece.Position, mFloatPieceArea);
				mFloatPieceList.push(mDraggedPiece);
			}
			
			mDraggedPiece = null;
			
			mSubmission = mCraftingTray.AssembleWord();
		}
		
		//private function OnClickDraggedPiece(aEvent:MouseEvent):void
		//{
			//stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			//stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			//mDraggedPiece.removeEventListener(MouseEvent.CLICK, OnClickDraggedPiece);
			//
			//
		//}
		
		private function OnClickSubmitBtn(aEvent:MouseEvent):void
		{
			mSubmitBtn.removeEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			
			mSubmission = mCraftingTray.AssembleWord();
			
			if (WordDictionary.Validate(mSubmission, 1))
			{
				var duration:Number = mCraftingTray.BounceInSequence();
				var fusionTimer:Timer = new Timer(duration * 1000, 1);
				fusionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnFusionTimerComplete);
				fusionTimer.start();
			}
			else
			{
				duration = mCraftingTray.FizzleAndExplode();
				var explosionTimer:Timer = new Timer(duration * 1000, 1)
				explosionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnExplosionTimerComplete);
				explosionTimer.start();
			}
		}
		
		private function OnFusionTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnFusionTimerComplete);
			
			mCompletedWordList.push(mSubmission);
			
			//var position:Point = new Point(mCraftingTray.Center, mCraftingTray.y);
			//var assembledWord:Piece = new Piece(null, null, mSubmission, position, ActivityType.WORD_CRAFTING.ColorCode);
			//DisplayObjectUtil.SetPosition(assembledWord, DisplayObjectUtil.GetPosition(mCraftingTray));
			//assembledWord.x += mCraftingTray.width / 2;
			//addChild(assembledWord);
			//TweenLite.to(assembledWord, 1, { ease:Strong.easeOut
			mToolTray.InsertLast(mSubmission, new Point(mCraftingTray.Center, mCraftingTray.y));
			mToolTray.BoxColor = ActivityType.WORD_CRAFTING.ColorCode;
			
			var valid:Boolean = false;
			//switch (mStringType)
			//{
				//case StringType.WORD:
					//valid = (mSubmission == mTargetWord);
					//break;
				//case StringType.RHYME:
					////valid = ;
					//break;
				//case StringType.ALLITERATION:
					////valid = ;
					//break;
				//default:
					//throw new Error("StringType " + mStringType.Description + " not handled.");
					//break;
			//}
			//if (mSubmission == mTargetWord)
			//if (valid)
			//{
				//AddStar();
				
				//mTargetWord = Random.FromList(TARGET_WORD_LIST);
				switch (mStringType)
				{
					case StringType.WORD:
						valid = (mSubmission == mTargetWord);
						if (valid)
						{
							if (!mTargetWordList.length)
							{
								var i:int, endi:int;
								var j:int, endj:int;
								for (i = 0, endi = TARGET_WORD_LIST.length; i < endi; ++i)
								{
									for (j = 0, endj = Inventory.SelectedLetterPatternCardList.length; j < endj; ++j)
									{
										if (TARGET_WORD_LIST[i].indexOf(Inventory.SelectedLetterPatternCardList[j]) > -1)
										{
											mTargetWordList.push(TARGET_WORD_LIST[i]);
											break;
										}
									}
								}
							}
							mTargetWord = Random.FromList(mTargetWordList);
							mTargetWordList.splice(mTargetWordList.indexOf(mTargetWord), 1);
							SoundManager.PlaySFX(Asset.WordContentSound["_" + mTargetWord]);
							mEarTargetWordTimer.reset();
							mEarTargetWordTimer.start();
						}
						break;
					case StringType.RHYME:
						valid = (mSubmission.lastIndexOf(mTargetRhyme) == mSubmission.length - mTargetRhyme.length);
						break;
					case StringType.ALLITERATION:
						valid = (mSubmission.indexOf(mTargetAlliteration) == 0);
						break;
					default:
						throw new Error("StringType " + mStringType.Description + " unhandled.");
						break;
				}
			//}
			
			if (valid)
			{
				AddStar();
			}
			
			mSubmission = "";
			mCraftingTray.Clear();
			mSubmitBtn.addEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			
			if (!mFloatPieceList.length && mCraftingTray.Empty && mBurpDone)
			{
				var closeMouthTimer:Timer = new Timer(300, 1);
				closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
				closeMouthTimer.start();
				
				TweenLite.killTweensOf(mWildLucu);
				TweenLite.to(mWildLucu, 1, { ease:Strong.easeInOut, delay:0.3, onComplete:OnTweenSendLucuBack,
					x:(1024 - 10 - (mWildLucu.width / 2)), y:(mMap.y - (mMap.height / 2) - 10 - (mWildLucu.height / 2)) });
			}
		}
		
		private function OnTweenShowHighlight(aHighlight:Sprite):void
		{
			TweenLite.to(aHighlight, 1.5, { ease:Strong.easeOut, onComplete:OnTweenHideHighlight,
				onCompleteParams:[aHighlight], scaleX:0.5, scaleY:0.5, alpha:0, rotation:255 });
		}
		
		private function OnTweenHideHighlight(aHighlight:Sprite):void
		{
			removeChild(aHighlight);
		}
		
		private function OnExplosionTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnExplosionTimerComplete);
			
			mSubmission = "";
			mCraftingTray.Clear();
			mSubmitBtn.addEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			
			if (!mFloatPieceList.length && mCraftingTray.Empty && mBurpDone)
			{
				var closeMouthTimer:Timer = new Timer(300, 1);
				closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
				closeMouthTimer.start();
				
				TweenLite.killTweensOf(mWildLucu);
				TweenLite.to(mWildLucu, 1, { ease:Strong.easeInOut, delay:0.3, onComplete:OnTweenSendLucuBack,
					x:(1024 - 10 - (mWildLucu.width / 2)), y:(mMap.y - (mMap.height / 2) - 10 - (mWildLucu.height / 2)) });
			}
		}
		
		private function OnTweenMoveLucuUp():void
		{
			TweenLite.to(mWildLucu, 2, {ease: Quad.easeInOut, x: 512, y: (384 + 5), onComplete: OnTweenMoveLucuDown});
		}
		
		private function OnTweenMoveLucuDown():void
		{
			TweenLite.to(mWildLucu, 2, {ease: Quad.easeInOut, x: 512, y: (384 - 5), onComplete: OnTweenMoveLucuUp});
		}
		
		private function OnEarTargetWordTimer(aEvent:TimerEvent):void
		{
			SoundManager.PlaySFX(Asset.WordContentSound["_" + mTargetWord]);
		}
		
		private function OnEnterFrame(aEvent:Event):void
		{
			var i:int, endi:int, iTarget:Point;
			var j:int, endj:int, jTarget:Point;
			var minDistance:Number;
			var distance:Point;
			for (i = 0, endi = mFloatPieceList.length; i < endi; ++i)
			{
				for (j = 0, endj = mFloatPieceList.length; j < endj; ++j)
				{
					if (j != i)
					{
						minDistance = (mFloatPieceList[j].width / 2) + (mFloatPieceList[i].width / 2);
						distance = DisplayObjectUtil.GetPosition(mFloatPieceList[j]);
						distance = distance.subtract(DisplayObjectUtil.GetPosition(mFloatPieceList[i]));
						if (distance.length <= minDistance)
						{
							distance.normalize((minDistance - distance.length) * 2);
							
							jTarget = DisplayObjectUtil.GetPosition(mFloatPieceList[j]).add(distance);
							jTarget = MathUtil.MinMaxPoint(jTarget, mFloatPieceArea);
							TweenLite.to(mFloatPieceList[j], 2, {ease: Quad.easeOut, overwrite: false, x: jTarget.x, y: jTarget.y});
							
							iTarget = DisplayObjectUtil.GetPosition(mFloatPieceList[i]).subtract(distance);
							iTarget = MathUtil.MinMaxPoint(iTarget, mFloatPieceArea);
							TweenLite.to(mFloatPieceList[i], 2, {ease: Quad.easeOut, overwrite: false, x: iTarget.x, y: iTarget.y});
						}
					}
				}
			}
		}
		
		private function OnOpenMouthTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnOpenMouthTimerComplete);
			
			SetWildLucu(Asset.WildLucuOpenBitmap);
		}
		
		private function OnTweenSendCard(aCard:CurvedBox):void
		{
			TweenLite.to(aCard, 0.4, { ease:Strong.easeOut, onComplete:OnTweenEatCard, onCompleteParams:[aCard],
				alpha:0, scaleX:0.1, scaleY:0.1 });
		}
		
		private function OnTweenEatCard(aCard:CurvedBox):void
		{
			removeChild(aCard);
		}
		
		private function OnStartBurpTimerTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnStartBurpTimerTimerComplete);
			
			switch (mStringType)
			{
				case StringType.WORD:
					mTargetWord = Random.FromList(mTargetWordList);
					mTargetWordList.splice(mTargetWordList.indexOf(mTargetWord), 1);
					SoundManager.PlaySFX(Asset.WordContentSound["_" + mTargetWord]);
					break;
				case StringType.RHYME:
					if (Asset.LetterAudioSound["_" + mTargetRhyme])
					{
						SoundManager.PlaySFX(Asset.LetterAudioSound["_" + mTargetRhyme]);
					}
					else if (Asset.NewChunkSound["_" + mTargetRhyme])
					{
						SoundManager.PlaySFX(Asset.NewChunkSound["_" + mTargetRhyme]);
					}
					else if (Asset.NewWordSound["_" + mTargetRhyme])
					{
						SoundManager.PlaySFX(Asset.NewWordSound["_" + mTargetRhyme]);
					}
					else if (Asset.WordContentSound["_" + mTargetRhyme])
					{
						SoundManager.PlaySFX(Asset.WordContentSound["_" + mTargetRhyme]);
					}
					break;
				case StringType.ALLITERATION:
					if (Asset.LetterAudioSound["_" + mTargetAlliteration])
					{
						SoundManager.PlaySFX(Asset.LetterAudioSound["_" + mTargetAlliteration]);
					}
					else if (Asset.NewChunkSound["_" + mTargetAlliteration])
					{
						SoundManager.PlaySFX(Asset.NewChunkSound["_" + mTargetAlliteration]);
					}
					else if (Asset.NewWordSound["_" + mTargetAlliteration])
					{
						SoundManager.PlaySFX(Asset.NewWordSound["_" + mTargetAlliteration]);
					}
					else if (Asset.WordContentSound["_" + mTargetAlliteration])
					{
						SoundManager.PlaySFX(Asset.WordContentSound["_" + mTargetAlliteration]);
					}
					break;
				default:
					throw new Error("StringType " + mStringType.Description + " unhandled.");
					break;
			}
			
			mEarTargetWordTimer.start();
			
			OnBurpTimer(null);
			mBurpTimer.start();
		}
		
		private function OnBurpTimer(aEvent:TimerEvent):void
		{
			var soundLength:Number = SoundManager.PlaySFX(Asset.BurpSound);
			
			SetWildLucu(Asset.WildLucuBurpBitmap);
			
			var closeMouthTimer:Timer = new Timer(soundLength, 1);
			closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
			closeMouthTimer.start();
			
			var label:String;
			var piece:Piece;
			var bubble:Bitmap;
			var target:Point;
			var difference:Point;
			for (var i:int = 0, endi:int = 3; i < endi; ++i)
			{
				label = GeneratePieceLabel();
				piece = new Piece(null, null, label, mMouthPosition, ActivityType.WORD_CRAFTING.ColorCode);
				DisplayObjectUtil.SetPosition(piece, mMouthPosition);
				piece.scaleX = piece.scaleY = 0.01;
				bubble = new Asset.BubbleBitmap();
				bubble.smoothing = true;
				bubble.width = Math.max(bubble.width, piece.width + 30);
				bubble.scaleY = bubble.scaleX;
				bubble.x = -bubble.width / 2;
				bubble.y = -bubble.height / 2;
				piece.addChild(bubble);
				addChild(piece);
				target = Random.Position2D(mFloatPieceArea);
				difference = target.subtract(mMouthPosition);
				if (difference.length <= 150)
				{
					target = target.add(difference);
				}
				target = MathUtil.MinMaxPoint(target, mFloatPieceArea);
				TweenLite.to(piece, 2, {ease: Quad.easeOut, delay: (i * 0.1), x: target.x, y: target.y});
				TweenLite.to(piece, 0.5, {ease: Strong.easeOut, delay: (i * 0.1), onComplete: OnTweenShowFloatPiece, onCompleteParams: [piece], alpha: 1, scaleX: 1, scaleY: 1});
			}
		}
		
		private function OnTweenShowFloatPiece(aPiece:Piece):void
		{
			aPiece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
			aPiece.addEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
			aPiece.StartDecay(30000);
			mFloatPieceList.push(aPiece);
		}
		
		private function OnCloseMouthTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
			
			SetWildLucu(Asset.WildLucuIdleBitmap);
		}
		
		private function OnClickFloatPiece(aEvent:MouseEvent):void
		{
			var piece:Piece = aEvent.currentTarget as Piece;
			piece.removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
			piece.removeEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
			
			piece.removeChildAt(piece.numChildren - 1);
			var bubbleSplash:Bitmap = new Asset.BubbleSplashBitmap();
			bubbleSplash.x = piece.x - (bubbleSplash.width / 2);
			bubbleSplash.y = piece.y - (bubbleSplash.height / 2);
			addChild(bubbleSplash);
			TweenLite.to(bubbleSplash, 1, { ease:Strong.easeOut, onComplete:OnTweenHideBubbleSplash,
				onCompleteParams:[bubbleSplash], alpha:0 });
			
			mSubmission += piece.Label;
			
			//var target:Point = DisplayObjectUtil.GetPosition(mCraftingTray);
			var target:Point = DisplayObjectUtil.GetPosition(mCraftingTray);
			//target.x = mCraftingTray.NextSlotPosition + (piece.width / 2);
			target.x = mCraftingTray.NextSlotPosition;
			if (mCraftingTray.Empty)
			{
				target.x -= 15;
			}
			target.x += (piece.width / 2);
			//target.x = mCraftingTray.NextSlotPosition + 20;
			//TweenLite.to(piece, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendFloatPiece, onCompleteParams:[piece],
			//x:target.x, y:target.y });
			//piece.Position = target;
			//TweenLite.to(this, 0.8, {onComplete: OnTweenSendFloatPiece, onCompleteParams:[piece] });
			mCraftingTray.InsertLast(piece.Label, piece.Position.subtract(DisplayObjectUtil.GetPosition(mCraftingTray)));
			mCraftingTray.BoxColor = ActivityType.WORD_CRAFTING.ColorCode;
			piece.Dispose();
			removeChild(piece);
			mFloatPieceList.splice(mFloatPieceList.indexOf(piece), 1);
			
			if (!mFloatPieceList.length && mCraftingTray.Empty && mBurpDone)
			{
				var closeMouthTimer:Timer = new Timer(300, 1);
				closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
				closeMouthTimer.start();
				
				TweenLite.killTweensOf(mWildLucu);
				TweenLite.to(mWildLucu, 1, { ease:Strong.easeInOut, delay:0.3, onComplete:OnTweenSendLucuBack,
					x:(1014 - (mWildLucu.width / 2)), y:(758 - (mWildLucu.height / 2)) });
			}
		}
		
		//private function OnTweenSendFloatPiece(aPiece:Piece):void
		//{
			////mCraftingTray.Insert(aPiece);
			////mCraftingTray.InsertLast(aPiece.Label, aPiece.Position.subtract(DisplayObjectUtil.GetPosition(mCraftingTray)));
			////mCraftingTray.BoxColor = ActivityType.WORD_CRAFTING.ColorCode;
			//
			////mFloatPieceList.splice(mFloatPieceList.indexOf(aPiece), 1);
			//
			////if (!mFloatPieceList.length)
			////{
				////var closeMouthTimer:Timer = new Timer(300, 1);
				////closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
				////closeMouthTimer.start();
				////
				////TweenLite.killTweensOf(mWildLucu);
				////TweenLite.to(mWildLucu, 1, { ease:Strong.easeInOut, delay:0.3, onComplete:OnTweenSendLucuBack,
				////x:(1014 - (mWildLucu.width / 2)), y:(758 - (mWildLucu.height / 2)) });
			////}
			//
			////removeChild(aPiece);
			//
			////mCraftingArea.Size = new Point(mCraftingTray.Bounds.width + 20, mCraftingArea.Size.y);
			////var contentWidth:Number = mCraftingTray.Bounds.width + 20 + mSubmitBtn.width;
			////mCraftingTray.x = -(contentWidth / 2);
			////mCraftingArea.Size = new Point(contentWidth + 20, mCraftingArea.Size.y);
		//}
		
		private function OnTweenHideBubbleSplash(aBubbleSplash:Bitmap):void
		{
			removeChild(aBubbleSplash);
		}
		
		private function OnRemoveFloatPiece(aEvent:PieceEvent):void
		{
			var piece:Piece = aEvent.currentTarget as Piece;
			piece.removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
			piece.removeEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
			
			TweenLite.to(piece, 0.5, {ease: Strong.easeOut, onComplete: OnTweenHideFloatPiece, onCompleteParams: [piece], alpha: 0});
			mFloatPieceList.splice(mFloatPieceList.indexOf(piece), 1);
			
			if (!mFloatPieceList.length && mCraftingTray.Empty && mBurpDone)
			{
				var closeMouthTimer:Timer = new Timer(300, 1);
				closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
				closeMouthTimer.start();
				
				TweenLite.killTweensOf(mWildLucu);
				TweenLite.to(mWildLucu, 1, { ease:Strong.easeInOut, delay:0.3, onComplete:OnTweenSendLucuBack,
					x:(1014 - (mWildLucu.width / 2)), y:(758 - (mWildLucu.height / 2)) });
			}
		}
		
		private function OnTweenHideFloatPiece(aPiece:Piece):void
		{
			TweenLite.killTweensOf(aPiece);
			aPiece.Dispose();
			removeChild(aPiece);
		}
		
		private function OnBurpTimerComplete(aEvent:TimerEvent):void
		{
			//var vacuumTimer:Timer = new Timer(35000, 1);
			//vacuumTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnVacuumTimerComplete);
			//vacuumTimer.start();
			
			mBurpDone = true;
		}
		
		//private function OnVacuumTimerComplete(aEvent:TimerEvent):void
		//{
		//if (mFloatPieceList.length)
		//{
		//// TODO:	vacuum sound
		//
		//SetWildLucu(Asset.WildLucuVacuumBitmap);
		//
		//removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
		//
		//var distance:Number;
		//var target:Point = mMouthPosition.add(new Point(-20, -15));
		//for (var i:int = 0, endi:int = mFloatPieceList.length; i < endi; ++i)
		//{
		//distance = target.subtract(DisplayObjectUtil.GetPosition(mFloatPieceList[i])).length;
		//mFloatPieceList[i].removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
		//TweenLite.to(mFloatPieceList[i], 2, { ease:Strong.easeIn, delay:(distance / 400),
		//onComplete:OnTweenVacuumFloatPiece, onCompleteParams:[mFloatPieceList[i]],
		//x:target.x, y:target.y });
		//}
		//}
		////else
		////{
		////var closeMouthTimer:Timer = new Timer(300, 1);
		////closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
		////closeMouthTimer.start();
		////
		////TweenLite.killTweensOf(mWildLucu);
		////TweenLite.to(mWildLucu, 1, { ease:Strong.easeInOut, delay:0.3, onComplete:OnTweenSendLucuBack,
		////x:(1014 - (mWildLucu.width / 2)), y:(758 - (mWildLucu.height / 2)) });
		////}
		//}
		
		//private function OnTweenVacuumFloatPiece(aPiece:Piece):void
		//{
		//TweenLite.to(aPiece, 0.4, { ease:Strong.easeOut, onComplete:OnTweenSwallowFloatPiece,
		//onCompleteParams:[aPiece], alpha:0, scaleX:0.01, scaleY:0.01 });
		//}
		
		//private function OnTweenSwallowFloatPiece(aPiece:Piece):void
		//{
		//aPiece.removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
		//aPiece.removeEventListener(PieceEvent.REMOVE, OnRemoveFloatPiece);
		//TweenLite.killTweensOf(aPiece);
		//aPiece.Dispose();
		//removeChild(aPiece);
		//mFloatPieceList.splice(mFloatPieceList.indexOf(aPiece), 1);
		//
		//if (!mFloatPieceList.length)
		//{
		//var closeMouthTimer:Timer = new Timer(300, 1);
		//closeMouthTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCloseMouthTimerComplete);
		//closeMouthTimer.start();
		//
		//TweenLite.killTweensOf(mWildLucu);
		//TweenLite.to(mWildLucu, 1, { ease:Strong.easeInOut, delay:0.3, onComplete:OnTweenSendLucuBack,
		//x:(1014 - (mWildLucu.width / 2)), y:(758 - (mWildLucu.height / 2)) });
		//}
		//}
		
		private function OnTweenSendLucuBack():void
		{
			Inventory.CompletedLucuTamingWordList = mCompletedWordList;
			Inventory.SelectableLucuTamingWord = mStartCount;
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}