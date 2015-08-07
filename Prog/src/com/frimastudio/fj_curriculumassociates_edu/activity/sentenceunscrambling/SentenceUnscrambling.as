package com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBox;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBoxEvent;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.Result;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.FontList;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.Piece;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
	import com.frimastudio.fj_curriculumassociates_edu.util.MathUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.MouseUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.frimastudio.fj_curriculumassociates_edu.util.StringUtil;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	public class SentenceUnscrambling extends Activity
	{
		private var mTemplate:SentenceUnscramblingTemplate;
		//private var mCraftingTrayField:CurvedBox;
		//private var mToolTray:PieceTray;
		private var mCraftingTray:PieceTray;
		private var mSubmitBtn:CurvedBox;
		private var mPreviousPosition:Piece;
		private var mDraggedPiece:Piece;
		//private var mSubmitedSentence:UIButton;
		private var mSubmitedSentence:Sprite;
		private var mSubmissionHighlight:Sprite;
		private var mAnswer:String;
		private var mResult:Result;
		private var mBlocker:Sprite;
		private var mSuccessFeedback:Sprite;
		private var mTutorialStep:int;
		private var mTutorialTimer:Timer;
		private var mDialogBox:CurvedBox;
		private var mActivityBox:ActivityBox;
		private var mStoredCraftingTrayChunkList:Vector.<String>;
		private var mFloatPieceList:Vector.<Piece>;
		private var mFloatPieceArea:Rectangle;
		//private var mToolTrayBox:Box;
		
		private function get SentenceIsCorrect():Boolean
		{
			return (mCraftingTray.AssembleSentence() == mTemplate.Answer);
		}
		
		public function SentenceUnscrambling(aTemplate:SentenceUnscramblingTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			//var sound:Sound = new Asset.GameHintSound[14]() as Sound;
			//sound.play();
			var soundLength:Number = SoundManager.PlayVO(Asset.GameHintSound[14]);
			
			var earAnswerTimer:Timer = new Timer(soundLength, 1);
			earAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarAnswerTimerComplete);
			earAnswerTimer.start();
			
			var areaY:Number = 180;
			var areaH:Number = 280;
			mFloatPieceArea = new Rectangle(100, areaY, 824, areaH);
			
			var wordList:Vector.<String> = mTemplate.WordList;
			//if (mTemplate.UseToolTray)
			if (mTemplate.UseWordBubble)
			{
				//mToolTrayBox = new Box(new Point(1024, 130), Palette.TOOL_BOX);
				//mToolTrayBox.x = 512;
				////toolTrayBox.y = 728;
				//mToolTrayBox.y = 838;
				//addChild(mToolTrayBox);
				//TweenLite.to(mToolTrayBox, 1.2, { ease:Elastic.easeOut, y:753 });
				
				//mToolTray = new PieceTray(false, wordList);
				//mToolTray.BoxColor = ActivityType.SENTENCE_UNSCRAMBLING.ColorCode;
				//mToolTray.x = 90;
				//mToolTray.y = 728;
				//mToolTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedToolTray);
				//addChild(mToolTray);
				
				mFloatPieceList = new Vector.<Piece>();
				var piece:Piece;
				var bubble:Bitmap;
				for (var i:int = 0, endi:int = wordList.length; i < endi; ++i)
				{
					piece = new Piece(null, null, wordList[i], Random.Position2D(mFloatPieceArea),
						ActivityType.SENTENCE_UNSCRAMBLING.ColorCode);
					bubble = new Asset.BubbleBitmap();
					bubble.smoothing = true;
					bubble.width = Math.max(bubble.width, piece.width + 30);
					bubble.scaleY = bubble.scaleX;
					bubble.x = -bubble.width / 2;
					bubble.y = -bubble.height / 2;
					piece.addChild(bubble);
					piece.addEventListener(MouseEvent.CLICK, OnClickFloatPiece);
					piece.scaleX = piece.scaleY = 0.01;
					addChild(piece);
					mFloatPieceList.push(piece);
					TweenLite.to(piece, 0.5, { ease:Elastic.easeOut, delay:(i * 0.1), scaleX:1, scaleY:1 });
				}
				
				addEventListener(Event.ENTER_FRAME, OnEnterFrame);
				
				wordList = null;
			}
			
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
			
			//mWildLucuChallengeBtn = new CurvedBox(new Point(64, 64), 0xD18B25,
				//new BoxIcon(Asset.WildLucuIdleBitmap, Palette.BTN_CONTENT), 6);
			//mWildLucuChallengeBtn.x = 1014 - (mWildLucuChallengeBtn.width / 2);
			//mWildLucuChallengeBtn.y = 758 - (mWildLucuChallengeBtn.height / 2);
			//mWildLucuChallengeBtn.addEventListener(MouseEvent.CLICK, OnClickWildLucuChallengeBtn);
			//addChild(mWildLucuChallengeBtn);
			//mWildLucu = new Sprite();
			//var wildLucuBitmap:Bitmap = new Asset.WildLucuIdleBitmap() as Bitmap;
			//wildLucuBitmap.smoothing = true;
			//wildLucuBitmap.scaleY = 0.5;
			//wildLucuBitmap.scaleX = -wildLucuBitmap.scaleY;
			//wildLucuBitmap.x = wildLucuBitmap.width / 2;
			//wildLucuBitmap.y = -wildLucuBitmap.height / 2;
			//mWildLucu.addChild(wildLucuBitmap);
			//mWildLucu.x = 1014 - (mWildLucu.width / 2);
			//mWildLucu.y = 758 - (mWildLucu.height / 2);
			//mWildLucu.addEventListener(MouseEvent.CLICK, OnClickWildLucu);
			//addChild(mWildLucu);
			
			InitializeMap();
			InitializeWildLucu();
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX,
				new BoxLabel("Put the words in order to make the sentence.", 45, Palette.DIALOG_CONTENT),
				6, Direction.UP_LEFT, Axis.BOTH);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = Math.min(mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2),
				668 - (mDialogBox.height / 2));
			addChild(mDialogBox);
			
			//var toolTrayBox:Box = new Box(new Point(1024, 90), Palette.TOOL_BOX);
			//toolTrayBox.x = 512;
			//toolTrayBox.y = 728;
			//addChild(toolTrayBox);
			
			//var craftingTrayBox:Box = new Box(new Point(1024, 90), Palette.CRAFTING_BOX);
			//craftingTrayBox.x = 512;
			//craftingTrayBox.y = 643;
			//addChild(craftingTrayBox);
			
			//mCraftingTrayField = new CurvedBox(new Point(910, 76), Palette.CRAFTING_FIELD);
			//mCraftingTrayField.x = 482;
			//mCraftingTrayField.y = 643;
			//addChild(mCraftingTrayField);
			
			//var craftingIcon:Bitmap = new Asset.IconWriteBitmap();
			//craftingIcon.x = 40;
			//craftingIcon.y = 643 - (craftingIcon.height / 2);
			//addChild(craftingIcon);
			
			//mActivityBox = new ActivityBox(mTemplate.ActivityWordList, mTemplate.LineBreakList, mTemplate.RequestVO,
				//mTemplate.PhylacteryArrow, true);
			mActivityBox = new ActivityBox(new Vector.<WordTemplate>(), new Vector.<int>(), mTemplate.RequestVO, mTemplate.PhylacteryArrow);
			mActivityBox.x = 512;
			mActivityBox.y = ((mTemplate.LineBreakList.length + 1) * 40) + 30;
			addChild(mActivityBox);
			
			mCraftingTray = new PieceTray(false, wordList);
			mCraftingTray.BoxColor = ActivityType.SENTENCE_UNSCRAMBLING.ColorCode;
			//mCraftingTray.x = 130;
			mCraftingTray.x = 40;
			mCraftingTray.y = 70;
			mCraftingTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedCraftingTray);
			addChild(mCraftingTray);
			
			mSubmitBtn = new CurvedBox(new Point(64, 64), Palette.GREAT_BTN,
				new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 6);
			//mSubmitBtn.x = 962;
			mSubmitBtn.x = 879;
			mSubmitBtn.y = 70;
			mSubmitBtn.addEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			addChild(mSubmitBtn);
			
			mResult = Result.WRONG;
			
			mBlocker = new Sprite();
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			mBlocker.graphics.beginFill(0x000000, 0);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.graphics.endFill();
			
			UpdateAnswer();
			
			mTutorialTimer = new Timer(3000);
			mTutorialTimer.addEventListener(TimerEvent.TIMER, OnTutorialTimer);
			mTutorialTimer.start();
		}
		
		private function OnEarAnswerTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnEarAnswerTimerComplete);
			
			//(new mTemplate.RequestVO() as Sound).play();
			SoundManager.PlayVO(mTemplate.RequestVO);
		}
		
		override public function Dispose():void 
		{
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			
			//mWildLucuChallengeBtn.removeEventListener(MouseEvent.CLICK, OnClickWildLucuChallengeBtn);
			mWildLucu.removeEventListener(MouseEvent.CLICK, OnClickWildLucu);
			
			//mToolTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedToolTray);
			//if (mToolTray)
			//{
				//mToolTray.removeEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedToolTray);
				//mToolTray.Dispose();
			//}
			
			mCraftingTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedCraftingTray);
			mCraftingTray.removeEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedCraftingTray);
			mCraftingTray.Dispose();
			
			if (mDraggedPiece)
			{
				mDraggedPiece.Dispose();
			}
			
			mActivityBox.Dispose();
			
			mSubmitBtn.removeEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			mBlocker.removeEventListener(MouseEvent.CLICK, OnClickBlocker);
			
			mTutorialTimer.removeEventListener(TimerEvent.TIMER, OnTutorialTimer);
			mTutorialTimer.reset();
			
			super.Dispose();
		}
		
		override public function Refresh():void
		{
			if (mLevel && mLevel != Level.NONE)
			{
				SoundManager.PlayVO(mTemplate.RequestVO);
			}
			
			super.Refresh();
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
							TweenLite.to(mFloatPieceList[j], 2, { ease:Quad.easeOut, overwrite:false, x:jTarget.x, y:jTarget.y });
							
							iTarget = DisplayObjectUtil.GetPosition(mFloatPieceList[i]).subtract(distance);
							iTarget = MathUtil.MinMaxPoint(iTarget, mFloatPieceArea);
							TweenLite.to(mFloatPieceList[i], 2, { ease:Quad.easeOut, overwrite:false, x:iTarget.x, y:iTarget.y });
						}
					}
				}
			}
		}
		
		private function UpdateAnswer():void
		{
			mActivityBox.UpdateCurrentActivityContent(mCraftingTray.AssembleChunkList(), true, false);
			//mSubmitBtn.BoxColor = Palette.GREAT_BTN;
		}
		
		private function ShowSuccessFeedback():void
		{
			//mSuccessFeedback = new Sprite();
			//mSuccessFeedback.addEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			//mSuccessFeedback.graphics.beginFill(0x000000, 0);
			//mSuccessFeedback.graphics.drawRect(0, 0, 1024, 768);
			//mSuccessFeedback.graphics.endFill();
			//mSuccessFeedback.alpha = 0;
			//addChild(mSuccessFeedback);
			
			//if (mSubmitedSentence)
			//{
				//addChild(mSubmitedSentence);
			//}
			
			//mSubmitBtn.BoxColor = mResult.Color;
			
			//var successLabel:TextField = new TextField();
			//successLabel.autoSize = TextFieldAutoSize.CENTER;
			//successLabel.selectable = false;
			//successLabel.filters = [new DropShadowFilter(1.5, 45, 0x000000, 1, 2, 2, 3, BitmapFilterQuality.HIGH)];
			
			//var sound:Sound;
			var sound:Class;
			switch (mResult)
			{
				case Result.GREAT:
					//successLabel.text = "Click to continue.";
					//sound = new Asset.CrescendoSound() as Sound;
					sound = Asset.CrescendoSound;
					break;
				//case Result.VALID:
					////successLabel.text = "Great sentence!\nClick to try again.";
					//(new Asset.ValidationSound() as Sound).play();
					//break;
				case Result.WRONG:
					//successLabel.text = "Click to try again.";
					//sound = new Asset.ErrorSound() as Sound;
					sound = Asset.ErrorSound;
					break;
				default:
					throw new Error(mResult ? "Result " + mResult.Description + " is not handled" : "No result to handle.");
					return;
			}
			//sound.play();
			var soundLength:Number = SoundManager.PlaySFX(sound);
			
			var concludeActivitySessionTimer:Timer = new Timer(soundLength, 1);
			concludeActivitySessionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnConcludeActivitySessionTimerComplete);
			concludeActivitySessionTimer.start();
			
			//successLabel.embedFonts = true;
			//successLabel.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 72, mResult.Color,
				//null, null, null, null, null, TextFormatAlign.CENTER));
			
			//successLabel.x = 512 - (successLabel.width / 2);
			//successLabel.y = 384 - (successLabel.height / 2);
			//var successBox:CurvedBox = new CurvedBox(new Point(successLabel.width + 24, successLabel.height), Palette.DIALOG_BOX);
			//successBox.alpha = 0.7;
			//successBox.x = 512;
			//successBox.y = 384;
			//mSuccessFeedback.addChild(successBox);
			//mSuccessFeedback.addChild(successLabel);
			
			//TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenShowSuccessFeedback, alpha:1 });
			if (mResult == Result.GREAT)
			{
				//if (mSubmitedSentence)
				//{
					//TweenLite.to(mSubmitedSentence, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSubmitedSentence, alpha:0 });
				//}
				mActivityBox.ProgressCurrentActivity();
			}
			
			if (mSubmissionHighlight)
			{
				TweenLite.to(mSubmissionHighlight, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSubmissionHighlight, alpha:0 });
			}
		}
		
		private function OnConcludeActivitySessionTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnConcludeActivitySessionTimerComplete);
			
			removeChild(mBlocker);
			
			if (mResult == Result.GREAT)
			{
				dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
			}
			//else
			//{
				//mCraftingTray.Clear(mStoredCraftingTrayChunkList);
				//mCraftingTray.BoxColor = ActivityType.SENTENCE_UNSCRAMBLING.ColorCode;
				//mCraftingTray.visible = true;
				//mStoredCraftingTrayChunkList = null;
			//}
		}
		
		private function OnTutorialTimer(aEvent:TimerEvent):void
		{
			switch (mTutorialStep)
			{
				case 0:
					//mToolTray.CallAttention(mTemplate.Answer.split(" ")[0].toLowerCase());
					break;
				default:
					mTutorialTimer.reset();
					break;
			}
		}
		
		private function OnClickFloatPiece(aEvent:MouseEvent):void
		{
			var piece:Piece = aEvent.currentTarget as Piece;
			piece.removeEventListener(MouseEvent.CLICK, OnClickFloatPiece);
			mFloatPieceList.splice(mFloatPieceList.indexOf(piece), 1);
			removeChild(piece);
			
			// SPLASH
			var bubbleSplash:Bitmap = new Asset.BubbleSplashBitmap();
			bubbleSplash.x = piece.x - (bubbleSplash.width / 2);
			bubbleSplash.y = piece.y - (bubbleSplash.height / 2);
			addChild(bubbleSplash);
			TweenLite.to(bubbleSplash, 1, { ease:Strong.easeOut, onComplete:OnTweenHideBubbleSplash,
				onCompleteParams:[bubbleSplash], alpha:0 });
			
			//var origin:Point = DisplayObjectUtil.GetPosition(piece).add(DisplayObjectUtil.GetPosition(mToolTray));
			var origin:Point = DisplayObjectUtil.GetPosition(piece);
			mCraftingTray.InsertLast(piece.Label, origin, true);
			mCraftingTray.BoxColor = ActivityType.SENTENCE_UNSCRAMBLING.ColorCode;
		}
		
		private function OnTweenHideBubbleSplash(aBubbleSplash:Bitmap):void
		{
			removeChild(aBubbleSplash);
		}
		
		//private function OnPieceFreedToolTray(aEvent:PieceTrayEvent):void
		//{
			//mTutorialStep = Math.max(mTutorialStep, 1);
			////if (mTutorialStep >= 1)
			////{
				////mCraftingTrayField.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
			////}
			//
			////mPreviousPosition = aEvent.EventPiece.NextPiece;
			////
			////mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this));
			////mDraggedPiece.BoxColor = ActivityType.SENTENCE_UNSCRAMBLING.ColorCode;
			////mDraggedPiece.ColorBorderOnly = true;
			////mDraggedPiece.y = mToolTray.y;
			////mDraggedPiece.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			////addChild(mDraggedPiece);
			////stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			////stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			//
			//var origin:Point = DisplayObjectUtil.GetPosition(aEvent.EventPiece).add(DisplayObjectUtil.GetPosition(mToolTray));
			//mCraftingTray.InsertLast(aEvent.EventPiece.Label, origin, true);
			//mCraftingTray.BoxColor = ActivityType.SENTENCE_UNSCRAMBLING.ColorCode;
			//
			////var word:String = StringUtil.ToLetterOnly(aEvent.EventPiece.Label).toLowerCase();
			//////if (Asset.WordSound["_" + aEvent.EventPiece.Label])
			////if (Asset.WordContentSound["_" + word])
			////{
				//////(new Asset.WordSound["_" + aEvent.EventPiece.Label]() as Sound).play();
				////(new Asset.WordContentSound["_" + word]() as Sound).play();
			////}
			//
			//mToolTray.Remove(aEvent.EventPiece);
			//
			//if (mToolTray.Empty)
			//{
				//TweenLite.to(mToolTrayBox, 0.3, { ease:Quad.easeIn, y:838 });
			//}
		//}
		
		private function OnPieceFreedCraftingTray(aEvent:PieceTrayEvent):void
		{
			//if (mTutorialStep >= 1)
			//{
				//mCraftingTrayField.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
			//}
			
			mPreviousPosition = aEvent.EventPiece.NextPiece;
			
			mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this));
			mDraggedPiece.BoxColor = ActivityType.SENTENCE_UNSCRAMBLING.ColorCode;
			mDraggedPiece.ColorBorderOnly = true;
			mDraggedPiece.y = mCraftingTray.y;
			mDraggedPiece.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			addChild(mDraggedPiece);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			mCraftingTray.Remove(aEvent.EventPiece);
			
			UpdateAnswer();
		}
		
		private function OnMouseMoveStage(aEvent:MouseEvent):void
		{
			mDraggedPiece.Position = MouseUtil.PositionRelativeTo(this);
			
			//if (Math.abs(mDraggedPiece.y - mToolTray.y) <= Math.abs(mDraggedPiece.y - mCraftingTray.y))
			//{
				//mToolTray.MakePlace(mDraggedPiece);
				//mCraftingTray.FreePlace();
			//}
			//else
			//{
				//mToolTray.FreePlace();
				mCraftingTray.MakePlace(mDraggedPiece);
			//}
		}
		
		private function OnMouseUpStage(aEvent:MouseEvent):void
		{
			//mCraftingTrayField.filters = [];
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			//if (Math.abs(mDraggedPiece.y - mToolTray.y) <= Math.abs(mDraggedPiece.y - mCraftingTray.y))
			//{
				//mToolTray.addEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedToolTray);
				//mToolTray.Insert(mDraggedPiece, mPreviousPosition);
			//}
			//else
			//{
				mCraftingTray.addEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedCraftingTray);
				mCraftingTray.Insert(mDraggedPiece, mPreviousPosition);
				mCraftingTray.BoxColor = ActivityType.SENTENCE_UNSCRAMBLING.ColorCode;
				
				UpdateAnswer();
			//}
		}
		
		//private function OnPieceCapturedToolTray(aEvent:PieceTrayEvent):void
		//{
			//mToolTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedToolTray);
			//
			//removeChild(aEvent.EventPiece);
			//if (aEvent.EventPiece == mDraggedPiece)
			//{
				//mDraggedPiece = null;
			//}
		//}
		
		private function OnPieceCapturedCraftingTray(aEvent:PieceTrayEvent):void
		{
			mTutorialStep = Math.max(mTutorialStep, 2);
			
			mCraftingTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedCraftingTray);
			
			removeChild(aEvent.EventPiece);
			if (aEvent.EventPiece == mDraggedPiece)
			{
				mDraggedPiece = null;
			}
			
			UpdateAnswer();
		}
		
		private function OnClickSubmitBtn(aEvent:MouseEvent):void
		{
			mStoredCraftingTrayChunkList = mCraftingTray.AssembleChunkList();
			
			var answer:String = mCraftingTray.AssembleSentence();
			if (answer.length)
			{
				mAnswer = answer;
				if (SentenceIsCorrect)
				{
					mResult = Result.GREAT;
				}
				else
				{
					mResult = Result.WRONG;
				}
				
				addChild(mBlocker);
				
				//mCraftingTray.BoxColor = (mResult == Result.GREAT ? ActivityType.SENTENCE_UNSCRAMBLING.ColorCode : mResult.Color);
				
				if (mResult == Result.WRONG)
				{
					mCraftingTray.Fizzle();
					var fizzleSentenceTimer:Timer = new Timer(700, 1);
					fizzleSentenceTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnFizzleSentenceTimerComplete);
					fizzleSentenceTimer.start();
				}
				else
				{
					var minimalDuration:Number = 0;
					if (mResult == Result.GREAT)
					{
						//var sound:Sound = new mTemplate.RequestVO() as Sound;
						//sound.play();
						var soundLength:Number = SoundManager.PlayVO(mTemplate.RequestVO);
						minimalDuration = soundLength;
						
						//mCraftingTray.BoxColor = ActivityType.SENTENCE_DECRYPTING.ColorCode;
						mCraftingTray.BoxColor = ActivityType.NONE.ColorCode;
						mCraftingTray.ProgressAllWords();
					}
					
					var bounceDuration:Number = mCraftingTray.BounceInSequence(true);
					var submitWordTimer:Timer = new Timer(Math.max(bounceDuration * 1000, minimalDuration), 1);
					submitWordTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnSubmitSentenceTimerComplete);
					submitWordTimer.start();
				}
				
				//(new Asset.SnappingSound() as Sound).play();
				SoundManager.PlaySFX(Asset.SnappingSound);
			}
			//else
			//{
				//mResult = Result.WRONG;
				//mSubmitBtn.BoxColor = mResult.Color;
			//}
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnFizzleSentenceTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnFizzleSentenceTimerComplete);
			
			//mCraftingTray.visible = false;
			
			ShowSuccessFeedback();
		}
		
		private function OnSubmitSentenceTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnSubmitSentenceTimerComplete);
			
			if (mResult == Result.GREAT)
			{
				mActivityBox.UpdateCurrentActivityContent(mCraftingTray.AssembleChunkList(), false, false);
			}
			ShowSuccessFeedback();
			
			////var target:Point = DisplayObjectUtil.GetPosition(mActivityBox);
			//var target:Point = mActivityBox.SentenceCenter;
			//var scale:Number = 1;
			//
			//var color:int = (mResult == Result.GREAT ? ActivityType.SENTENCE_UNSCRAMBLING.ColorCode : mResult.Color);
			////mSubmitedSentence = new UIButton(mAnswer, color);
			//mSubmitedSentence = new Sprite();
			//var chunkLabelList:Vector.<String> = mCraftingTray.AssembleChunkList();
			//var chunkList:Vector.<CurvedBox> = new Vector.<CurvedBox>();
			//var chunk:CurvedBox;
			//var chunkOffset:Number = 0;
			//var i:int, endi:int;
			//for (i = 0, endi = chunkLabelList.length; i < endi; ++i)
			//{
				//chunk = new CurvedBox(new Point(60, 60), color, new BoxLabel(chunkLabelList[i], 45, Palette.DIALOG_CONTENT),
					//3, null, Axis.HORIZONTAL);
				//chunk.ColorBorderOnly = true;
				//chunkOffset += chunk.width / 2;
				//chunk.x = chunkOffset;
				//mSubmitedSentence.addChild(chunk);
				//chunkList.push(chunk);
				//chunkOffset += (chunk.width) / 2 + 15;
			//}
			//var sentenceOffset:Number = -mSubmitedSentence.width / 2;
			//for (i = 0, endi = chunkList.length; i < endi; ++i)
			//{
				//chunkList[i].x += sentenceOffset;
			//}
			//mSubmitedSentence.x = mCraftingTray.Center;
			//mSubmitedSentence.y = mCraftingTray.y;
			////mSubmitedSentence.width = mCraftingTray.width;
			//
			//if (mResult == Result.GREAT)
			//{
				//mSubmissionHighlight = new Sprite();
				//mSubmissionHighlight.x = mSubmitedSentence.x;
				//mSubmissionHighlight.y = mSubmitedSentence.y;
				//mSubmissionHighlight.addEventListener(Event.ENTER_FRAME, OnEnterFrameSubmissionHighlight);
				//var highlightBitmap:Bitmap = new Asset.SubmissionHighlightBitmap() as Bitmap;
				//highlightBitmap.smoothing = true;
				//highlightBitmap.x = -highlightBitmap.width / 2;
				//highlightBitmap.y = -highlightBitmap.height / 2;
				//mSubmissionHighlight.addChild(highlightBitmap);
				//addChild(mSubmissionHighlight);
				//
				//TweenLite.to(mSubmissionHighlight, 0.5, { ease:Strong.easeOut, x:target.x, y:target.y } );
				//
				////(new Asset.FusionSound() as Sound).play();
				////(new mTemplate.RequestVO() as Sound).play();
			//}
			//addChild(mSubmitedSentence);
			//
			//mCraftingTray.visible = false;
			//
			//TweenLite.to(mSubmitedSentence, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendSubmitedSentence,
				//x:target.x, y:target.y, scaleX:scale, scaleY:scale });
		}
		
		private function OnEnterFrameSubmissionHighlight(aEvent:Event):void
		{
			mSubmissionHighlight.rotation += 3;
		}
		
		private function OnTweenSendSubmitedSentence():void
		{
			if (mResult == Result.GREAT)
			{
				mActivityBox.UpdateCurrentActivityContent(mCraftingTray.AssembleChunkList(), false, false);
			}
			
			//mSubmitedSentence.addEventListener(MouseEvent.CLICK, OnClickSubmitedSentence);
			
			ShowSuccessFeedback();
		}
		
		//private function OnClickSubmitedSentence(aEvent:MouseEvent):void
		//{
			//(new Asset.SentenceSound["_the_field_is_on_a_hill"]() as Sound).play();
		//}
		
		private function OnTweenShowSuccessFeedback():void
		{
			removeChild(mBlocker);
			
			//if (mResult == Result.GREAT)
			//{
				//(new Asset.SentenceSound["_the_field_is_on_a_hill"]() as Sound).play();
			//}
		}
		
		private function OnClickSuccessFeedback(aEvent:MouseEvent):void
		{
			mSuccessFeedback.removeEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			//if (mSubmitedSentence)
			//{
				//mSubmitedSentence.removeEventListener(MouseEvent.CLICK, OnClickSubmitedSentence);
				//TweenLite.to(mSubmitedSentence, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSubmitedSentence, alpha:0 } );
			//}
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSuccessFeedback, alpha:0 } );
			
			if (mResult != Result.GREAT)
			{
				mCraftingTray.Clear(mStoredCraftingTrayChunkList);
				mCraftingTray.BoxColor = ActivityType.SENTENCE_UNSCRAMBLING.ColorCode;
				//mToolTray.Clear(mTemplate.WordList);
				mCraftingTray.visible = true;
				
				mStoredCraftingTrayChunkList = null;
			}
		}
		
		private function OnTweenHideSubmitedSentence():void
		{
			//mSubmitedSentence.Dispose();
			removeChild(mSubmitedSentence);
			mSubmitedSentence = null;
		}
		
		private function OnTweenHideSubmissionHighlight():void
		{
			removeChild(mSubmissionHighlight);
			mSubmissionHighlight.removeEventListener(Event.ENTER_FRAME, OnEnterFrameSubmissionHighlight);
			mSubmissionHighlight = null;
		}
		
		private function OnTweenHideSuccessFeedback():void
		{
			removeChild(mSuccessFeedback);
			mSuccessFeedback = null;
			
			if (mResult == Result.GREAT)
			{
				dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
			}
		}
	}
}