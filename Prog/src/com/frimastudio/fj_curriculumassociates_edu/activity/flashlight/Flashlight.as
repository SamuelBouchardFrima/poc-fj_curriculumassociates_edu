package com.frimastudio.fj_curriculumassociates_edu.activity.flashlight
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.Result;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.FontList;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
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
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class Flashlight extends Activity
	{
		private var mTemplate:FlashlightTemplate;
		private var mFlashlight:Sprite;
		private var mPictureMaskList:Vector.<Sprite>;
		private var mPictureList:Vector.<Sprite>;
		private var mResult:Result;
		private var mBlocker:Sprite;
		private var mSuccessFeedback:Sprite;
		private var mDebug:Sprite;
		private var mValidateAnswerTimer:Timer;
		private var mShowAnswerTimer:Timer;
		private var mShowFeedbackTimer:Timer;
		
		public function Flashlight(aTemplate:FlashlightTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			var background:Sprite = new Sprite();
			background.graphics.beginFill(Palette.CRAFTING_BOX);
			background.graphics.drawRect(0, 0, 1024, 768);
			addChild(background);
			
			var lamp:Bitmap = new Asset.LampOnBitmap[2]();
			lamp.x = 800 - (lamp.width / 2);
			lamp.y = 340 - (lamp.height / 2);
			addChild(lamp);
			
			var lucu:Bitmap = new Asset.FlashlightLucuBitmap();
			lucu.x = 800 - (lucu.width / 2);
			lucu.y = 475 - (lucu.height / 2);
			addChild(lucu);
			
			mFlashlight = new Sprite();
			mFlashlight.x = 835;
			mFlashlight.y = 415;
			mFlashlight.rotation = -15;
			var flashlightBitmap:Bitmap = new Asset.FlashlightBitmap();
			flashlightBitmap.smoothing = true;
			flashlightBitmap.x = 50 - flashlightBitmap.width;
			flashlightBitmap.y = 130 - (flashlightBitmap.height / 2);
			mFlashlight.addChild(flashlightBitmap);
			addChild(mFlashlight);
			TweenLite.to(mFlashlight, 5, { onComplete:OnTweenTurnFlashlightUp, rotation:45 } );
			
			mPictureMaskList = new Vector.<Sprite>();
			mPictureList = new Vector.<Sprite>();
			var picture:Sprite;
			var pictureBitmap:Bitmap;
			for (var i:int = 0, endi:int = mTemplate.PictureAssetList.length; i < endi; ++i)
			{
				mPictureMaskList.push(new Sprite());
				addChild(mPictureMaskList[i]);
				
				picture = new Sprite();
				picture.x = 190 + (70 * Math.abs((i - ((endi / 2) - 0.5)) / ((endi / 2) - 0.5)));
				picture.y = 290 + (300 * (i / (endi - 1)));
				pictureBitmap = new mTemplate.PictureAssetList[i]();
				pictureBitmap.smoothing = true;
				pictureBitmap.height = (400 - ((endi - 1) * 10)) / endi;
				pictureBitmap.scaleX = pictureBitmap.scaleY;
				pictureBitmap.x = -pictureBitmap.width / 2;
				pictureBitmap.y = -pictureBitmap.height / 2;
				picture.addChild(pictureBitmap);
				picture.mask = mPictureMaskList[i];
				picture.addEventListener(MouseEvent.CLICK, OnClickPicture);
				addChild(picture);
				mPictureList.push(picture);
			}
			
			var requestTube:Bitmap = new Asset.RequestTubeBitmap();
			requestTube.x = 70;
			requestTube.y = -20;
			addChild(requestTube);
			
			var request:TextField = new TextField();
			request.selectable = false;
			request.width = 200;
			request.height = 96;
			request.autoSize = TextFieldAutoSize.CENTER;
			request.text = mTemplate.Request.toUpperCase();
			request.setTextFormat(new TextFormat(FontList.SEMI_BOLD, 96, Palette.BTN_CONTENT,
				null, null, null, null, null, "center"));
			var highlightStart:int = mTemplate.Request.indexOf(mTemplate.Highlight);
			var highlightEnd:int = highlightStart + mTemplate.Highlight.length;
			request.setTextFormat(new TextFormat(FontList.SEMI_BOLD, 96, Palette.HIGHLIGHT_CONTENT,
				null, null, null, null, null, "center"), highlightStart, highlightEnd);
			request.x = 512 - (request.width / 2);
			request.y = 48;
			addChild(request);
			
			mResult = Result.WRONG;
			
			mBlocker = new Sprite();
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			mBlocker.graphics.beginFill(0x000000, 0);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.graphics.endFill();
			
			mDebug = new Sprite();
			addChild(mDebug);
			
			mValidateAnswerTimer = new Timer(700, 1);
			mValidateAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnValidateAnswerTimerComplete);
			
			mShowAnswerTimer = new Timer(700, 1);
			mShowAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnShowAnswerTimerComplete);
			
			mShowFeedbackTimer = new Timer(700, 1);
			mShowFeedbackTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnShowFeedbackTimerComplete);
			
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
		}
		
		override public function Dispose():void
		{
			TweenLite.killTweensOf(mFlashlight);
			
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			
			var i:int, endi:int;
			for (i = 0, endi = mPictureList.length; i < endi; ++i)
			{
				TweenLite.killTweensOf(mPictureList[i]);
				mPictureList[i].removeEventListener(MouseEvent.CLICK, OnClickPicture);
			}
			
			mBlocker.removeEventListener(MouseEvent.CLICK, OnClickBlocker);
			
			mValidateAnswerTimer.reset();
			mValidateAnswerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnValidateAnswerTimerComplete);
			
			mShowAnswerTimer.reset();
			mShowAnswerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnShowAnswerTimerComplete);
			
			mShowFeedbackTimer.reset();
			mShowFeedbackTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnShowFeedbackTimerComplete);
			
			super.Dispose();
		}
		
		private function OnEnterFrame(aEvent:Event):void
		{
			var origin:Point = mFlashlight.localToGlobal(new Point(15, 98));
			var targetA:Point = mFlashlight.localToGlobal(new Point(-800, 116));
			var targetB:Point = mFlashlight.localToGlobal(new Point( -800, 286));
			
			for (var i:int = 0, endi:int = mPictureMaskList.length; i < endi; ++i)
			{
				mPictureMaskList[i].graphics.clear();
				mPictureMaskList[i].graphics.lineStyle();
				mPictureMaskList[i].graphics.beginFill(0x000000);
				mPictureMaskList[i].graphics.moveTo(origin.x, origin.y);
				mPictureMaskList[i].graphics.lineTo(targetA.x, targetA.y);
				mPictureMaskList[i].graphics.lineTo(targetB.x, targetB.y);
				mPictureMaskList[i].graphics.lineTo(origin.x, origin.y);
				mPictureMaskList[i].graphics.endFill();
			}
		}
		
		private function OnTweenTurnFlashlightUp():void
		{
			TweenLite.to(mFlashlight, 5, { onComplete:OnTweenTurnFlashlightDown, rotation:-15 });
		}
		
		private function OnTweenTurnFlashlightDown():void
		{
			TweenLite.to(mFlashlight, 5, { onComplete:OnTweenTurnFlashlightUp, rotation:45 });
		}
		
		private function OnClickPicture(aEvent:MouseEvent):void
		{
			addChild(mBlocker);
			
			TweenLite.killTweensOf(mFlashlight);
			
			var index:int = mPictureList.indexOf(aEvent.currentTarget as Sprite);
			(new mTemplate.AudioAssetList[index]() as Sound).play();
			mResult = (index == mTemplate.Answer ? Result.GREAT : Result.WRONG);
			
			mValidateAnswerTimer.reset();
			mValidateAnswerTimer.start();
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnValidateAnswerTimerComplete(aEvent:TimerEvent):void
		{
			mValidateAnswerTimer.reset();
			
			if (mResult == Result.GREAT)
			{
				(new Asset.CrescendoSound() as Sound).play();
				
				mPictureList[mTemplate.Answer].mask = null;
				removeChild(mPictureMaskList[mTemplate.Answer]);
				
				addChild(mPictureList[mTemplate.Answer]);
				TweenLite.to(mPictureList[mTemplate.Answer], 1, { ease:Elastic.easeOut, scaleX:3, scaleY:3, x:512, y:434 } );
				
				mShowFeedbackTimer.reset();
				mShowFeedbackTimer.start();
			}
			else
			{
				(new Asset.ErrorSound() as Sound).play();
				
				var target:Number = (((mTemplate.PictureAssetList.length - 1) - mTemplate.Answer) /
					(mTemplate.PictureAssetList.length - 1)) * 30;
				TweenLite.to(mFlashlight, 0.7, { onComplete:OnTweenFlashlightToAnswer, rotation:target });
			}
		}
		
		private function OnTweenFlashlightToAnswer():void
		{
			mShowAnswerTimer.reset();
			mShowAnswerTimer.start();
		}
		
		private function OnShowAnswerTimerComplete(aEvent:TimerEvent):void
		{
			mShowAnswerTimer.reset();
			
			(new mTemplate.AudioAssetList[mTemplate.Answer] as Sound).play();
			
			mPictureList[mTemplate.Answer].mask = null;
			removeChild(mPictureMaskList[mTemplate.Answer]);
			
			TweenLite.to(mPictureList[mTemplate.Answer], 1, { ease:Elastic.easeOut, scaleX:3, scaleY:3, x:512, y:434 });
			
			mShowFeedbackTimer.reset();
			mShowFeedbackTimer.start();
		}
		
		private function OnShowFeedbackTimerComplete(aEvent:TimerEvent):void
		{
			mShowFeedbackTimer.reset();
			
			mSuccessFeedback = new Sprite();
			mSuccessFeedback.addEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			mSuccessFeedback.graphics.beginFill(0x000000, 0);
			mSuccessFeedback.graphics.drawRect(0, 0, 1024, 768);
			mSuccessFeedback.graphics.endFill();
			mSuccessFeedback.alpha = 0;
			var successLabel:TextField = new TextField();
			successLabel.autoSize = TextFieldAutoSize.CENTER;
			successLabel.selectable = false;
			successLabel.filters = [new DropShadowFilter(1.5, 45, 0x000000, 1, 2, 2, 3, BitmapFilterQuality.HIGH)];
			successLabel.text = (mResult == Result.GREAT ? "Great!\nClick to continue." : "Almost!\nClick to continue.");
			successLabel.setTextFormat(new TextFormat(FontList.SEMI_BOLD, 72, mResult.Color,
				null, null, null, null, null, "center"));
			successLabel.x = 512 - (successLabel.width / 2);
			successLabel.y = 384 - (successLabel.height / 2);
			mSuccessFeedback.addChild(successLabel);
			addChild(mSuccessFeedback);
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenShowSuccessFeedback, alpha:1 });
		}
		
		private function OnTweenShowSuccessFeedback():void
		{
			removeChild(mBlocker);
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