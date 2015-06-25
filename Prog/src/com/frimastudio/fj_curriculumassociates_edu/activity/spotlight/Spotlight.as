package com.frimastudio.fj_curriculumassociates_edu.activity.spotlight
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.Result;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.FontList;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	public class Spotlight extends Activity
	{
		private var mTemplate:SpotlightTemplate;
		private var mLampList:Vector.<Bitmap>;
		private var mLucuList:Vector.<Sprite>;
		private var mRequest:TextField;
		private var mAnswer:int;
		private var mAttempt:int;
		private var mResult:Result;
		private var mBlocker:Sprite;
		private var mSuccessFeedback:Sprite;
		private var mPositiveFeedbackTimer:Timer;
		private var mValidateAnswerTimer:Timer;
		private var mShowAnswerTimer:Timer;
		private var mShowFeedbackTimer:Timer;
		
		public function Spotlight(aTemplate:SpotlightTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			var i:int, endi:int;
			var offset:Number = 1024 / (mTemplate.AudioList.length + 0.2);
			
			var background:Sprite = new Sprite();
			background.graphics.beginFill(Palette.CRAFTING_BOX);
			background.graphics.drawRect(0, 0, 1024, 768);
			background.graphics.endFill();
			addChild(background);
			
			mLampList = new Vector.<Bitmap>();
			var lamp:Bitmap;
			for (i = 0, endi = mTemplate.AudioList.length; i < endi; ++i)
			{
				lamp = new Asset.LampOnBitmap[i]();
				lamp.x = ((i + 0.5) * offset) - (lamp.width / 2);
				lamp.y = 360 - (lamp.height / 2);
				addChild(lamp);
				mLampList.push(lamp);
			}
			
			mLucuList = new Vector.<Sprite>();
			var lucu:Sprite;
			var lucuBitmap:Bitmap;
			for (i = 0, endi = mTemplate.AudioList.length; i < endi; ++i)
			{
				lucu = new Sprite();
				lucuBitmap = new Asset.NewLucuBitmap[i]();
				lucuBitmap.x = -lucuBitmap.width / 2;
				lucuBitmap.y = -lucuBitmap.height / 2;
				lucu.addChild(lucuBitmap);
				lucu.x = (i + 0.5) * offset;
				lucu.y = 605;
				lucu.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOverLucu);
				lucu.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOutLucu);
				lucu.addEventListener(MouseEvent.CLICK, OnClickLucu);
				addChild(lucu);
				mLucuList.push(lucu);
			}
			
			var requestTube:Bitmap = new Asset.RequestTubeBitmap();
			requestTube.x = 70;
			requestTube.y = -20;
			addChild(requestTube);
			
			mRequest = new TextField();
			mRequest.selectable = false;
			mRequest.width = 200;
			mRequest.height = 96;
			mRequest.autoSize = TextFieldAutoSize.CENTER;
			mRequest.text = mTemplate.Request;
			mRequest.embedFonts = true;
			mRequest.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 72, Palette.DIALOG_BOX,
				null, null, null, null, null, TextFormatAlign.CENTER));
			var highlightStart:int = mTemplate.Request.indexOf(mTemplate.Highlight);
			var highlightEnd:int = highlightStart + mTemplate.Highlight.length;
			mRequest.x = 512 - (mRequest.width / 2);
			mRequest.y = 52;
			
			var requestLabel:CurvedBox = new CurvedBox(new Point(mRequest.width + 24, mRequest.height), Palette.DIALOG_BOX);
			requestLabel.x = 512;
			requestLabel.y = 106;
			addChild(requestLabel);
			
			addChild(mRequest);
			
			var requestLetter:TextField;
			var boundaries:Rectangle;
			for (i = 0, endi = mTemplate.Request.length; i < endi; ++i)
			{
				boundaries = mRequest.getCharBoundaries(i);
				Geometry.RectangleAdd(boundaries, new Point(407, 50));
				boundaries.height = Math.max(boundaries.height, mRequest.height);
				requestLetter = new TextField();
				requestLetter.selectable = false;
				requestLetter.width = boundaries.width + 10;
				requestLetter.height = boundaries.height;
				requestLetter.text = mTemplate.Request.charAt(i);
				requestLetter.embedFonts = true;
				requestLetter.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 72,
					(i >= highlightStart && i < highlightEnd ? Palette.HIGHLIGHT_CONTENT : Palette.DIALOG_CONTENT),
					null, null, null, null, null, TextFormatAlign.CENTER));
				requestLetter.x = boundaries.x;
				requestLetter.y = boundaries.y;
				requestLetter.alpha = 0;
				addChild(requestLetter);
				TweenLite.to(requestLetter, 0.5, { ease:Strong.easeOut, delay:(i * 0.1), onComplete:OnTweenShowRequestLetter,
					onCompleteParams:[requestLetter, i], x:requestLetter.x, y:requestLetter.y, scaleX:1, scaleY:1, alpha:1 });
				requestLetter.scaleX = requestLetter.scaleY = 8;
				requestLetter.x -= requestLetter.width / 2;
				requestLetter.y -= requestLetter.height / 2;
			}
			
			mResult = Result.WRONG;
			
			mBlocker = new Sprite();
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			mBlocker.graphics.beginFill(0x000000, 0);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.graphics.endFill();
			addChild(mBlocker);
			
			mPositiveFeedbackTimer = new Timer(700, 1);
			mPositiveFeedbackTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnPositiveFeedbackTimerComplete);
			
			mValidateAnswerTimer = new Timer(700, 1);
			mValidateAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnValidateAnswerTimerComplete);
			
			mShowAnswerTimer = new Timer(700, 1);
			mShowAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnShowAnswerTimerComplete);
			
			mShowFeedbackTimer = new Timer(700, 1);
			mShowFeedbackTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnShowFeedbackTimerComplete);
			
			var startLessonTimer:Timer = new Timer((mTemplate.Request.length * 100) + 500, 1);
			if (!mTemplate.SkipInstruction)
			{
				var instruction:Sound = new Asset.SpotlightInstructionSound() as Sound;
				instruction.play();
				startLessonTimer.delay = Math.max(startLessonTimer.delay, instruction.length);
			}
			startLessonTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnStartLessonTimerComplete);
			startLessonTimer.start();
		}
		
		override public function Dispose():void
		{
			var i:int, endi:int;
			for (i = 0, endi = mLucuList.length; i < endi; ++i)
			{
				mLucuList[i].removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOverLucu);
				mLucuList[i].removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOutLucu);
				mLucuList[i].removeEventListener(MouseEvent.CLICK, OnClickLucu);
			}
			
			mBlocker.removeEventListener(MouseEvent.CLICK, OnClickBlocker);
			
			mPositiveFeedbackTimer.reset();
			mPositiveFeedbackTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnPositiveFeedbackTimerComplete);
			
			mValidateAnswerTimer.reset();
			mValidateAnswerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnValidateAnswerTimerComplete);
			
			mShowAnswerTimer.reset();
			mShowAnswerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnShowAnswerTimerComplete);
			
			mShowFeedbackTimer.reset();
			mShowFeedbackTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnShowFeedbackTimerComplete);
			
			super.Dispose();
		}
		
		private function OnStartLessonTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnStartLessonTimerComplete);
			
			removeChild(mBlocker);
		}
		
		private function OnTweenShowRequestLetter(aLetter:TextField, aIndex:int):void
		{
			removeChild(aLetter);
			
			var highlightStart:int = mTemplate.Request.indexOf(mTemplate.Highlight);
			var highlightEnd:int = highlightStart + mTemplate.Highlight.length;
			var color:int = (aIndex >= highlightStart && aIndex < highlightEnd ? Palette.HIGHLIGHT_CONTENT : Palette.DIALOG_CONTENT);
			mRequest.setTextFormat(new TextFormat(null, null, color), aIndex, aIndex + 1);
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnMouseOverLucu(aEvent:MouseEvent):void
		{
			var lucu:Sprite = aEvent.currentTarget as Sprite;
			lucu.transform.colorTransform = new ColorTransform(1.3, 1.3, 1.3);
			
			mLampList[mLucuList.indexOf(lucu)].alpha = 1.6;
			
			(new Asset.SpotlightSound["_" + mTemplate.AudioList[mLucuList.indexOf(lucu)]]() as Sound).play();
		}
		
		private function OnMouseOutLucu(aEvent:MouseEvent):void
		{
			if (!contains(mBlocker) && !mSuccessFeedback)
			{
				var lucu:Sprite = aEvent.currentTarget as Sprite;
				lucu.transform.colorTransform = new ColorTransform();
				
				mLampList[mLucuList.indexOf(lucu)].alpha = 1;
			}
		}
		
		private function OnClickLucu(aEvent:MouseEvent):void
		{
			addChild(mBlocker);
			
			++mAttempt;
			
			mAnswer = mLucuList.indexOf(aEvent.currentTarget as Sprite);
			(new Asset.ClickSound() as Sound).play();
			
			mResult = (mAnswer == mTemplate.Answer ? Result.GREAT : Result.WRONG);
			
			if (mResult == Result.GREAT)
			{
				mPositiveFeedbackTimer.delay = 700;
				mPositiveFeedbackTimer.reset();
				mPositiveFeedbackTimer.start();
			}
			else
			{
				mValidateAnswerTimer.delay = 700;
				mValidateAnswerTimer.reset();
				mValidateAnswerTimer.start();
			}
		}
		
		private function OnPositiveFeedbackTimerComplete(aEvent:TimerEvent):void
		{
			var sound:Sound = (new (Random.FromList(Asset.PositiveFeedbackSound) as Class)() as Sound);
			sound.play();
			
			mValidateAnswerTimer.delay = sound.length;
			mValidateAnswerTimer.reset();
			mValidateAnswerTimer.start();
		}
		
		private function OnValidateAnswerTimerComplete(aEvent:TimerEvent):void
		{
			mValidateAnswerTimer.reset();
			
			if (mResult != Result.GREAT)
			{
				var lamp:Bitmap = new Asset.LampOffBitmap[mAnswer]();
				lamp.x = ((mAnswer + 0.5) * (1024 / (mTemplate.AudioList.length + 0.2))) - (lamp.width / 2);
				lamp.y = 360 - (lamp.height / 2);
				addChildAt(lamp, getChildIndex(mLampList[mAnswer]));
				removeChild(mLampList[mAnswer]);
				mLampList[mAnswer] = lamp;
				
				mLucuList[mAnswer].transform.colorTransform = new ColorTransform(0.3, 0.3, 0.3);
			}
			
			if (mResult == Result.GREAT)
			{
				(new Asset.CrescendoSound() as Sound).play();
				mShowFeedbackTimer.delay = 700;
				mShowFeedbackTimer.reset();
				mShowFeedbackTimer.start();
			}
			else
			{
				(new Asset.ErrorSound() as Sound).play();
				
				mLucuList[mAnswer].removeChildAt(0);
				var lucuBitmap:Bitmap = new Asset.NewLucuAngryBitmap[mAnswer]();
				lucuBitmap.x = -lucuBitmap.width / 2;
				lucuBitmap.y = -lucuBitmap.height / 2;
				mLucuList[mAnswer].addChild(lucuBitmap);
				
				if (mAttempt < 2)
				{
					mLucuList[mAnswer].removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOverLucu);
					mLucuList[mAnswer].removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOutLucu);
					mLucuList[mAnswer].removeEventListener(MouseEvent.CLICK, OnClickLucu);
					
					removeChild(mBlocker);
				}
				else
				{
					mShowAnswerTimer.reset();
					mShowAnswerTimer.start();
				}
			}
		}
		
		private function OnShowAnswerTimerComplete(aEvent:TimerEvent):void
		{
			mShowAnswerTimer.reset();
			
			mLampList[mTemplate.Answer].alpha = 1.6;
			
			mLucuList[mTemplate.Answer].transform.colorTransform = new ColorTransform(1.3, 1.3, 1.3);
			
			var sound:Sound = (new Asset.SpotlightCorrectSound["_" + mTemplate.AudioList[mTemplate.Answer]]() as Sound);
			sound.play();
			
			mShowFeedbackTimer.delay = sound.length;
			mShowFeedbackTimer.reset();
			mShowFeedbackTimer.start();
		}
		
		private function OnShowFeedbackTimerComplete(aEvent:TimerEvent):void
		{
			mShowFeedbackTimer.reset();
			
			var offset:Number = 1024 / (mTemplate.AudioList.length + 0.2);
			for (var i:int = 0, endi:int = mLampList.length; i < endi; ++i)
			{
				if (i != mTemplate.Answer)
				{
					var lamp:Bitmap = new Asset.LampOffBitmap[i]();
					lamp.x = ((i + 0.5) * offset) - (lamp.width / 2);
					lamp.y = 360 - (lamp.height / 2);
					addChildAt(lamp, getChildIndex(mLampList[i]));
					removeChild(mLampList[i]);
					mLampList[i] = lamp;
					mLucuList[i].transform.colorTransform = new ColorTransform(0.3, 0.3, 0.3);
				}
			}
			
			mSuccessFeedback = new Sprite();
			mSuccessFeedback.addEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			mSuccessFeedback.graphics.beginFill(0x000000, 0.7);
			mSuccessFeedback.graphics.drawRect(0, 0, 1024, 768);
			mSuccessFeedback.graphics.endFill();
			mSuccessFeedback.alpha = 0;
			var continueBtn:Bitmap = new Asset.ContinueBtnLucuBitmap() as Bitmap;
			continueBtn.x = 512 - (continueBtn.width / 2);
			continueBtn.y = 384 - (continueBtn.height / 2);
			var successBox:CurvedBox = new CurvedBox(new Point(continueBtn.width, continueBtn.height), 0xCCCCCC);
			successBox.x = 512;
			successBox.y = 384;
			mSuccessFeedback.addChild(successBox);
			mSuccessFeedback.addChild(continueBtn);
			addChild(mSuccessFeedback);
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenShowSuccessFeedback, alpha:1 });
		}
		
		private function OnTweenShowSuccessFeedback():void
		{
			removeChild(mBlocker);
			
			(new Asset.ClickToContinueSound() as Sound).play();
		}
		
		private function OnClickSuccessFeedback(aEvent:MouseEvent):void
		{
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSuccessFeedback, alpha:0 });
		}
		
		private function OnTweenHideSuccessFeedback():void
		{
			TweenLite.killTweensOf(mSuccessFeedback);
			mSuccessFeedback.removeEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			removeChild(mSuccessFeedback);
			mSuccessFeedback = null;
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}