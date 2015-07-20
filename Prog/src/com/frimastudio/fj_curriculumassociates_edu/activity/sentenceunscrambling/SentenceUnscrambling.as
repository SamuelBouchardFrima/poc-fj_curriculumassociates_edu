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
	import com.frimastudio.fj_curriculumassociates_edu.util.MouseUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.StringUtil;
	import com.greensock.easing.Elastic;
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
			
			//mToolTray = new PieceTray(false, mTemplate.WordList);
			//mToolTray.x = 90;
			//mToolTray.y = 728;
			//mToolTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedToolTray);
			//addChild(mToolTray);
			
			//mActivityBox = new ActivityBox(mTemplate.ActivityWordList, mTemplate.LineBreakList, mTemplate.RequestVO,
				//mTemplate.PhylacteryArrow, true);
			mActivityBox = new ActivityBox(new Vector.<WordTemplate>(), new Vector.<int>(), mTemplate.RequestVO, mTemplate.PhylacteryArrow);
			mActivityBox.x = 512;
			mActivityBox.y = ((mTemplate.LineBreakList.length + 1) * 40) + 30;
			addChild(mActivityBox);
			
			mCraftingTray = new PieceTray(false, mTemplate.WordList);
			mCraftingTray.BoxColor = ActivityType.SENTENCE_UNSCRAMBLING.ColorCode;
			//mCraftingTray.x = 130;
			mCraftingTray.x = 40;
			mCraftingTray.y = 70;
			mCraftingTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedCraftingTray);
			addChild(mCraftingTray);
			
			mSubmitBtn = new CurvedBox(new Point(64, 64), Palette.GREAT_BTN,
				new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 6);
			mSubmitBtn.x = 962;
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
		
		//private function OnPieceFreedToolTray(aEvent:PieceTrayEvent):void
		//{
			//mTutorialStep = Math.max(mTutorialStep, 1);
			//if (mTutorialStep >= 1)
			//{
				//mCraftingTrayField.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
			//}
			//
			//mPreviousPosition = aEvent.EventPiece.NextPiece;
			//
			//mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this));
			//mDraggedPiece.y = mToolTray.y;
			//mDraggedPiece.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			//addChild(mDraggedPiece);
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			//stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			//
			//var word:String = StringUtil.ToLetterOnly(aEvent.EventPiece.Label).toLowerCase();
			////if (Asset.WordSound["_" + aEvent.EventPiece.Label])
			//if (Asset.WordContentSound["_" + word])
			//{
				////(new Asset.WordSound["_" + aEvent.EventPiece.Label]() as Sound).play();
				//(new Asset.WordContentSound["_" + word]() as Sound).play();
			//}
			//
			//mToolTray.Remove(aEvent.EventPiece);
		//}
		
		private function OnPieceFreedCraftingTray(aEvent:PieceTrayEvent):void
		{
			if (mTutorialStep >= 1)
			{
				//mCraftingTrayField.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
			}
			
			mPreviousPosition = aEvent.EventPiece.NextPiece;
			
			mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Label, MouseUtil.PositionRelativeTo(this));
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