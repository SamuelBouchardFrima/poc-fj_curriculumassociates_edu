package com.frimastudio.fj_curriculumassociates_edu.activity.flashlight
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.Result;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.FontList;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
	import com.frimastudio.fj_curriculumassociates_edu.util.MathUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.MouseUtil;
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
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
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
		private var mRequest:TextField;
		private var mAnswer:int;
		private var mResult:Result;
		private var mBlocker:Sprite;
		private var mSuccessFeedback:Sprite;
		private var mEarAnswerTimer:Timer;
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
			background.graphics.endFill();
			addChild(background);
			
			var lamp:Bitmap = new Asset.LampOnBitmap[2]();
			lamp.x = 820 - (lamp.width / 2);
			lamp.y = 380 - (lamp.height / 2);
			addChild(lamp);
			
			var lucu:Bitmap = new Asset.FlashlightLucuBitmap();
			lucu.x = 820 - (lucu.width / 2);
			lucu.y = 515 - (lucu.height / 2);
			addChild(lucu);
			
			mFlashlight = new Sprite();
			mFlashlight.x = 855;
			mFlashlight.y = 455;
			mFlashlight.rotation = -10;
			var flashlightBitmap:Bitmap = new Asset.FlashlightOffBitmap();
			flashlightBitmap.smoothing = true;
			flashlightBitmap.x = 50 - flashlightBitmap.width;
			flashlightBitmap.y = 130 - (flashlightBitmap.height / 2);
			mFlashlight.addChild(flashlightBitmap);
			addChild(mFlashlight);
			
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
				picture.addEventListener(MouseEvent.ROLL_OVER, OnRollOverPicture);
				picture.addEventListener(MouseEvent.ROLL_OUT, OnRollOutPicture);
				picture.addEventListener(MouseEvent.CLICK, OnClickPicture);
				addChild(picture);
				mPictureList.push(picture);
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
			mRequest.text = mTemplate.Request.toUpperCase();
			mRequest.setTextFormat(new TextFormat(FontList.SEMI_BOLD, 96, 0x66FF99,
				null, null, null, null, null, "center"));
			var highlightStart:int = mTemplate.Request.indexOf(mTemplate.Highlight);
			var highlightEnd:int = highlightStart + mTemplate.Highlight.length;
			mRequest.x = 512 - (mRequest.width / 2);
			mRequest.y = 48;
			addChild(mRequest);
			
			var requestLetter:TextField;
			var boundaries:Rectangle;
			for (i = 0, endi = mTemplate.Request.length; i < endi; ++i)
			{
				boundaries = mRequest.getCharBoundaries(i);
				Geometry.RectangleAdd(boundaries, new Point(512 - (mRequest.width / 2) + 82, 48 - 2));
				boundaries.height = Math.max(boundaries.height, mRequest.height);
				requestLetter = new TextField();
				requestLetter.selectable = false;
				requestLetter.width = boundaries.width + 10;
				requestLetter.height = boundaries.height;
				requestLetter.text = mTemplate.Request.charAt(i).toUpperCase();
				requestLetter.setTextFormat(new TextFormat(FontList.SEMI_BOLD, 96,
					(i >= highlightStart && i < highlightEnd ? Palette.HIGHLIGHT_CONTENT : Palette.BTN_CONTENT),
					null, null, null, null, null, "center"));
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
			
			mEarAnswerTimer = new Timer(300, 1);
			mEarAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarAnswerTimerComplete);
			
			mValidateAnswerTimer = new Timer(1000, 1);
			mValidateAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnValidateAnswerTimerComplete);
			
			mShowAnswerTimer = new Timer(700, 1);
			mShowAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnShowAnswerTimerComplete);
			
			mShowFeedbackTimer = new Timer(700, 1);
			mShowFeedbackTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnShowFeedbackTimerComplete);
			
			addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			
			var instruction:Sound = new Asset.FlashlightInstructionSound() as Sound;
			instruction.play();
			var instructionTimer:Timer = new Timer(instruction.length, 1);
			instructionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			instructionTimer.start();
		}
		
		override public function Dispose():void
		{
			TweenLite.killTweensOf(mFlashlight);
			
			removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			
			mBlocker.removeEventListener(MouseEvent.CLICK, OnClickBlocker);
			
			mEarAnswerTimer.reset();
			mEarAnswerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnEarAnswerTimerComplete);
			
			mValidateAnswerTimer.reset();
			mValidateAnswerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnValidateAnswerTimerComplete);
			
			mShowAnswerTimer.reset();
			mShowAnswerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnShowAnswerTimerComplete);
			
			mShowFeedbackTimer.reset();
			mShowFeedbackTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnShowFeedbackTimerComplete);
			
			super.Dispose();
		}
		
		private function OnInstructionTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			
			removeChild(mBlocker);
			
			mFlashlight.removeChildAt(0);
			var flashlightBitmap:Bitmap = new Asset.FlashlightBitmap();
			flashlightBitmap.smoothing = true;
			flashlightBitmap.x = 50 - flashlightBitmap.width;
			flashlightBitmap.y = 130 - (flashlightBitmap.height / 2);
			mFlashlight.addChild(flashlightBitmap);
			
			var origin:Point = mFlashlight.localToGlobal(new Point(15, 98));
			var cursor:Point = MouseUtil.PositionRelativeTo(this);
			var axis:Point = origin.subtract(cursor);
			var angle:Number = Math.atan2(axis.y, axis.x) * 180 / Math.PI;
			TweenLite.to(mFlashlight, 0.5, { ease:Quad.easeOut, rotation:MathUtil.MinMax(angle + 7.5, -10, 50) });
		}
		
		private function OnTweenShowRequestLetter(aLetter:TextField, aIndex:int):void
		{
			removeChild(aLetter);
			
			var highlightStart:int = mTemplate.Request.indexOf(mTemplate.Highlight);
			var highlightEnd:int = highlightStart + mTemplate.Highlight.length;
			var color:int = (aIndex >= highlightStart && aIndex < highlightEnd ? Palette.HIGHLIGHT_CONTENT : Palette.BTN_CONTENT);
			mRequest.setTextFormat(new TextFormat(null, null, color), aIndex, aIndex + 1);
		}
		
		private function OnMouseMove(aEvent:MouseEvent):void
		{
			if (!contains(mBlocker) && !mSuccessFeedback)
			{
				var origin:Point = mFlashlight.localToGlobal(new Point(15, 98));
				var cursor:Point = MouseUtil.PositionRelativeTo(this);
				var axis:Point = origin.subtract(cursor);
				var angle:Number = Math.atan2(axis.y, axis.x) * 180 / Math.PI;
				TweenLite.to(mFlashlight, 0.5, { ease:Quad.easeOut, rotation:MathUtil.MinMax(angle + 7.5, -10, 50) });
			}
		}
		
		private function OnEnterFrame(aEvent:Event):void
		{
			var origin:Point = mFlashlight.localToGlobal(new Point(15, 98));
			var targetA:Point = mFlashlight.localToGlobal(new Point(-800, 116));
			var targetB:Point = mFlashlight.localToGlobal(new Point(-800, 286));
			
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
		
		private function OnRollOverPicture(aEvent:MouseEvent):void
		{
			var picture:Sprite = aEvent.currentTarget as Sprite;
			picture.filters = [new GlowFilter(0xFFFFFF, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			picture.mask = null;
			if (contains(mPictureMaskList[mPictureList.indexOf(picture)]))
			{
				removeChild(mPictureMaskList[mPictureList.indexOf(picture)]);
			}
		}
		
		private function OnRollOutPicture(aEvent:MouseEvent):void
		{
			if (!contains(mBlocker) && !mSuccessFeedback)
			{
				var picture:Sprite = aEvent.currentTarget as Sprite;
				picture.filters = [];
				picture.mask = mPictureMaskList[mPictureList.indexOf(picture)];
				addChild(mPictureMaskList[mPictureList.indexOf(picture)]);
			}
		}
		
		private function OnClickPicture(aEvent:MouseEvent):void
		{
			addChild(mBlocker);
			
			var i:int, endi:int;
			for (i = 0, endi = mPictureList.length; i < endi; ++i)
			{
				TweenLite.killTweensOf(mPictureList[i]);
				mPictureList[i].removeEventListener(MouseEvent.ROLL_OVER, OnRollOverPicture);
				mPictureList[i].removeEventListener(MouseEvent.ROLL_OUT, OnRollOutPicture);
				mPictureList[i].removeEventListener(MouseEvent.CLICK, OnClickPicture);
			}
			
			TweenLite.killTweensOf(mFlashlight);
			
			mAnswer = mPictureList.indexOf(aEvent.currentTarget as Sprite);
			(new Asset.ClickSound() as Sound).play();
			
			mResult = (mAnswer == mTemplate.Answer ? Result.GREAT : Result.WRONG);
			
			mEarAnswerTimer.reset();
			mEarAnswerTimer.start();
			
			mValidateAnswerTimer.reset();
			mValidateAnswerTimer.start();
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnEarAnswerTimerComplete(aEvent:TimerEvent):void
		{
			mEarAnswerTimer.reset();
			
			(new mTemplate.AudioAssetList[mAnswer] as Sound).play();
		}
		
		private function OnValidateAnswerTimerComplete(aEvent:TimerEvent):void
		{
			mValidateAnswerTimer.reset();
			
			if (mResult == Result.GREAT)
			{
				(new Asset.CrescendoSound() as Sound).play();
				
				mPictureList[mTemplate.Answer].filters =
					[new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
				
				mPictureList[mTemplate.Answer].mask = null;
				if (contains(mPictureMaskList[mTemplate.Answer]))
				{
					removeChild(mPictureMaskList[mTemplate.Answer]);
				}
				
				addChild(mPictureList[mTemplate.Answer]);
				TweenLite.to(mPictureList[mTemplate.Answer], 1, { ease:Elastic.easeOut, scaleX:3, scaleY:3, x:512, y:434 } );
				
				mShowFeedbackTimer.reset();
				mShowFeedbackTimer.start();
			}
			else
			{
				(new Asset.ErrorSound() as Sound).play();
				
				mPictureList[mAnswer].filters =
					[new GlowFilter(Palette.WRONG_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
				
				var target:Number = ((((mTemplate.PictureAssetList.length - 1) - mTemplate.Answer) /
					(mTemplate.PictureAssetList.length - 1)) * 30) + 2.5;
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
			
			addChild(mPictureList[mTemplate.Answer]);
			
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