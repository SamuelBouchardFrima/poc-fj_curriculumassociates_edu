package com.frimastudio.fj_curriculumassociates_edu.activity.flashlight
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.Result;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.FontList;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
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
		private var mFlashlightBeam:Sprite;
		private var mFlashlight:Sprite;
		private var mPictureMaskList:Vector.<Sprite>;
		private var mPictureList:Vector.<Sprite>;
		private var mRequest:TextField;
		private var mAnswer:int;
		private var mAttempt:int;
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
			
			mFlashlightBeam = new Sprite();
			mFlashlightBeam.x = 512;
			mFlashlightBeam.y = 650;
			mFlashlightBeam.filters = [new GlowFilter(0xFFFFFF, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			mFlashlightBeam.alpha = 0;
			addChild(mFlashlightBeam);
			
			mFlashlight = new Sprite();
			mFlashlight.x = 512;
			mFlashlight.y = 768;
			mFlashlight.transform.colorTransform = new ColorTransform(0.3, 0.3, 0.3);
			var flashlightBitmap:Bitmap = new Asset.FlashlightBitmap();
			flashlightBitmap.smoothing = true;
			flashlightBitmap.x = -flashlightBitmap.width / 2;
			flashlightBitmap.y = -flashlightBitmap.height / 2;
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
				picture.x = mTemplate.PicturePositionList[i].x;
				picture.y = mTemplate.PicturePositionList[i].y;
				pictureBitmap = new mTemplate.PictureAssetList[i]();
				pictureBitmap.smoothing = true;
				pictureBitmap.x = -pictureBitmap.width / 2;
				pictureBitmap.y = -pictureBitmap.height / 2;
				picture.addChild(pictureBitmap);
				picture.mask = mPictureMaskList[i];
				picture.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOverPicture);
				picture.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOutPicture);
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
			mRequest.text = mTemplate.Request;
			mRequest.embedFonts = true;
			mRequest.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 72, Palette.DIALOG_BOX,
				null, null, null, null, null, "center"));
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
			
			var i:int, endi:int;
			for (i = 0, endi = mPictureList.length; i < endi; ++i)
			{
				TweenLite.killTweensOf(mPictureList[i]);
				mPictureList[i].removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOverPicture);
				mPictureList[i].removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOutPicture);
				mPictureList[i].removeEventListener(MouseEvent.CLICK, OnClickPicture);
			}
			
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
			
			mFlashlight.transform.colorTransform = new ColorTransform();
			
			mFlashlightBeam.alpha = 1;
			
			var origin:Point = mFlashlight.localToGlobal(new Point(0, -20));
			var target:Point = MouseUtil.PositionRelativeTo(this);
			target.y = Math.min(target.y, 650);
			var axis:Point = origin.subtract(target);
			var angle:Number = (Math.atan2(axis.y, axis.x) * 180 / Math.PI) - 90;
			TweenLite.to(mFlashlight, 0.5, { ease:Quad.easeOut, rotation:angle });
			TweenLite.to(mFlashlightBeam, 0.5, { ease:Quad.easeOut, x:target.x, y:target.y });
		}
		
		private function OnTweenShowRequestLetter(aLetter:TextField, aIndex:int):void
		{
			removeChild(aLetter);
			
			var highlightStart:int = mTemplate.Request.indexOf(mTemplate.Highlight);
			var highlightEnd:int = highlightStart + mTemplate.Highlight.length;
			var color:int = (aIndex >= highlightStart && aIndex < highlightEnd ? Palette.HIGHLIGHT_CONTENT : Palette.DIALOG_CONTENT);
			mRequest.setTextFormat(new TextFormat(null, null, color), aIndex, aIndex + 1);
		}
		
		private function OnMouseMove(aEvent:MouseEvent):void
		{
			if (!contains(mBlocker) && !mSuccessFeedback)
			{
				var origin:Point = mFlashlight.localToGlobal(new Point(0, -20));
				var target:Point = MouseUtil.PositionRelativeTo(this);
				target.y = Math.min(target.y, 650);
				var axis:Point = origin.subtract(target);
				var angle:Number = (Math.atan2(axis.y, axis.x) * 180 / Math.PI) - 90;
				TweenLite.to(mFlashlight, 0.5, { ease:Quad.easeOut, rotation:angle });
				TweenLite.to(mFlashlightBeam, 0.5, { ease:Quad.easeOut, x:target.x, y:target.y });
			}
		}
		
		private function OnEnterFrame(aEvent:Event):void
		{
			var origin:Point = mFlashlight.localToGlobal(new Point(0, -20));
			var axis:Point = origin.subtract(DisplayObjectUtil.GetPosition(mFlashlightBeam));
			var angle:Number = (Math.atan2(axis.y, axis.x) * 180 / Math.PI) - 90;
			var spotSize:Number = 80 + (axis.length / 4);
			var elipse:Rectangle = new Rectangle(mouseX - ((spotSize * 1.2) / 2), mouseY - (spotSize / 2),
				spotSize * 1.2, spotSize);
			
			mFlashlightBeam.graphics.clear();
			mFlashlightBeam.graphics.beginFill(0xFFFFFF, 0.75);
			mFlashlightBeam.graphics.drawEllipse(-elipse.width / 2, -elipse.height / 2, elipse.width, elipse.height);
			mFlashlightBeam.graphics.endFill();
			
			for (var i:int = 0, endi:int = mPictureMaskList.length; i < endi; ++i)
			{
				mPictureMaskList[i].x = mFlashlightBeam.x;
				mPictureMaskList[i].y = mFlashlightBeam.y;
				mPictureMaskList[i].graphics.clear();
				mPictureMaskList[i].graphics.lineStyle();
				mPictureMaskList[i].graphics.beginFill(0x000000);
				mPictureMaskList[i].graphics.drawEllipse(-elipse.width / 2, -elipse.height / 2, elipse.width, elipse.height);
				mPictureMaskList[i].graphics.endFill();
			}
		}
		
		private function OnMouseOverPicture(aEvent:MouseEvent):void
		{
			var picture:Sprite = aEvent.currentTarget as Sprite;
			picture.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
		}
		
		private function OnMouseOutPicture(aEvent:MouseEvent):void
		{
			if (!contains(mBlocker) && !mSuccessFeedback)
			{
				var picture:Sprite = aEvent.currentTarget as Sprite;
				picture.filters = [];
			}
		}
		
		private function OnClickPicture(aEvent:MouseEvent):void
		{
			addChild(mBlocker);
			
			++mAttempt;
			
			TweenLite.killTweensOf(mFlashlight);
			
			mAnswer = mPictureList.indexOf(aEvent.currentTarget as Sprite);
			(new Asset.ClickSound() as Sound).play();
			
			mResult = (mAnswer == mTemplate.Answer ? Result.GREAT : Result.WRONG);
			
			mEarAnswerTimer.reset();
			mEarAnswerTimer.start();
			
			//mValidateAnswerTimer.reset();
			//mValidateAnswerTimer.start();
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnEarAnswerTimerComplete(aEvent:TimerEvent):void
		{
			mEarAnswerTimer.reset();
			
			//(new mTemplate.AudioAssetList[mAnswer] as Sound).play();
			var sound:Sound = (new mTemplate.AudioAssetList[mAnswer] as Sound);
			sound.play();
			
			mValidateAnswerTimer.delay = sound.length;
			mValidateAnswerTimer.reset();
			mValidateAnswerTimer.start();
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
				
				mShowFeedbackTimer.delay = 500;
				mShowFeedbackTimer.reset();
				mShowFeedbackTimer.start();
			}
			else
			{
				(new Asset.ErrorSound() as Sound).play();
				
				mPictureList[mAnswer].filters =
					[new GlowFilter(Palette.WRONG_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
				
				if (mAttempt < 2)
				{
					TweenLite.killTweensOf(mPictureList[mAnswer]);
					mPictureList[mAnswer].removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOverPicture);
					mPictureList[mAnswer].removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOutPicture);
					mPictureList[mAnswer].removeEventListener(MouseEvent.CLICK, OnClickPicture);
					
					removeChild(mBlocker);
				}
				else
				{
					var origin:Point = DisplayObjectUtil.GetPosition(mFlashlight);
					var axis:Point = origin.subtract(DisplayObjectUtil.GetPosition(mPictureList[mTemplate.Answer]));
					var angle:Number = (Math.atan2(axis.y, axis.x) * 180 / Math.PI) - 90;
					TweenLite.to(mFlashlightBeam, 0.7, { x:mPictureList[mTemplate.Answer].x, y:mPictureList[mTemplate.Answer].y });
					TweenLite.to(mFlashlight, 0.7, { onComplete:OnTweenFlashlightToAnswer, rotation:angle });
				}
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
			
			//(new mTemplate.AudioAssetList[mTemplate.Answer] as Sound).play();
			//(new mTemplate.CorrectAudio as Sound).play();
			var sound:Sound = (new mTemplate.CorrectAudio as Sound);
			sound.play();
			
			mPictureList[mTemplate.Answer].mask = null;
			removeChild(mPictureMaskList[mTemplate.Answer]);
			
			addChild(mPictureList[mTemplate.Answer]);
			
			TweenLite.to(mPictureList[mTemplate.Answer], 1, { ease:Elastic.easeOut, scaleX:3, scaleY:3, x:512, y:434 });
			
			mShowFeedbackTimer.delay = sound.length;
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
			successLabel.embedFonts = true;
			successLabel.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 72, mResult.Color,
				null, null, null, null, null, "center"));
			successLabel.x = 512 - (successLabel.width / 2);
			successLabel.y = 384 - (successLabel.height / 2);
			var successBox:CurvedBox = new CurvedBox(new Point(successLabel.width + 24, successLabel.height), Palette.DIALOG_BOX);
			successBox.alpha = 0.7;
			successBox.x = 512;
			successBox.y = 384;
			mSuccessFeedback.addChild(successBox);
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