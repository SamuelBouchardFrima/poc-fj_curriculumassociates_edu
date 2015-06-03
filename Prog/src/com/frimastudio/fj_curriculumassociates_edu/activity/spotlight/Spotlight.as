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
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Geometry;
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
	import flash.utils.Timer;
	
	public class Spotlight extends Activity
	{
		private var mTemplate:SpotlightTemplate;
		private var mLampList:Vector.<Bitmap>;
		private var mLucuList:Vector.<Sprite>;
		private var mRequest:TextField;
		private var mAnswer:int;
		private var mResult:Result;
		private var mBlocker:Sprite;
		private var mSuccessFeedback:Sprite;
		private var mValidateAnswerTimer:Timer;
		private var mShowAnswerTimer:Timer;
		private var mShowFeedbackTimer:Timer;
		
		public function Spotlight(aTemplate:SpotlightTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			var i:int, endi:int;
			var offset:Number = 1024 / (mTemplate.AudioAssetList.length + 0.2);
			
			var background:Sprite = new Sprite();
			background.graphics.beginFill(Palette.CRAFTING_BOX);
			background.graphics.drawRect(0, 0, 1024, 768);
			background.graphics.endFill();
			addChild(background);
			
			mLampList = new Vector.<Bitmap>();
			var lamp:Bitmap;
			for (i = 0, endi = mTemplate.AudioAssetList.length; i < endi; ++i)
			{
				lamp = new Asset.LampOffBitmap[i]();
				lamp.x = ((i + 0.5) * offset) - (lamp.width / 2);
				lamp.y = 340 - (lamp.height / 2);
				addChild(lamp);
				mLampList.push(lamp);
			}
			
			mLucuList = new Vector.<Sprite>();
			var lucu:Sprite;
			var lucuBitmap:Bitmap;
			var colorTransform:ColorTransform = new ColorTransform(0.4, 0.4, 0.4);
			for (i = 0, endi = mTemplate.AudioAssetList.length; i < endi; ++i)
			{
				lucu = new Sprite();
				lucuBitmap = new Asset.LucuBitmap();
				lucuBitmap.x = -lucuBitmap.width / 2;
				lucuBitmap.y = -lucuBitmap.height / 2;
				lucu.addChild(lucuBitmap);
				lucu.x = (i + 0.5) * offset;
				lucu.y = 475;
				lucu.addEventListener(MouseEvent.ROLL_OVER, OnRollOverLucu);
				lucu.addEventListener(MouseEvent.ROLL_OUT, OnRollOutLucu);
				lucu.addEventListener(MouseEvent.CLICK, OnClickLucu);
				lucu.transform.colorTransform = colorTransform;
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
			
			mValidateAnswerTimer = new Timer(700, 1);
			mValidateAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnValidateAnswerTimerComplete);
			
			mShowAnswerTimer = new Timer(700, 1);
			mShowAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnShowAnswerTimerComplete);
			
			mShowFeedbackTimer = new Timer(700, 1);
			mShowFeedbackTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnShowFeedbackTimerComplete);
			
			var instruction:Sound = new Asset.SpotlightInstructionSound() as Sound;
			instruction.play();
			var instructionTimer:Timer = new Timer(instruction.length, 1);
			instructionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			instructionTimer.start();
		}
		
		override public function Dispose():void
		{
			var i:int, endi:int;
			for (i = 0, endi = mLucuList.length; i < endi; ++i)
			{
				mLucuList[i].removeEventListener(MouseEvent.ROLL_OVER, OnRollOverLucu);
				mLucuList[i].removeEventListener(MouseEvent.ROLL_OUT, OnRollOutLucu);
				mLucuList[i].removeEventListener(MouseEvent.CLICK, OnClickLucu);
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
		
		private function OnInstructionTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			
			removeChild(mBlocker);
		}
		
		private function OnTweenShowRequestLetter(aLetter:TextField, aIndex:int):void
		{
			removeChild(aLetter);
			
			var highlightStart:int = mTemplate.Request.indexOf(mTemplate.Highlight);
			var highlightEnd:int = highlightStart + mTemplate.Highlight.length;
			var color:int = (aIndex >= highlightStart && aIndex < highlightEnd ? Palette.HIGHLIGHT_CONTENT : Palette.BTN_CONTENT);
			mRequest.setTextFormat(new TextFormat(null, null, color), aIndex, aIndex + 1);
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnRollOverLucu(aEvent:MouseEvent):void
		{
			var lucu:Sprite = aEvent.currentTarget as Sprite;
			lucu.transform.colorTransform = new ColorTransform();
			(new mTemplate.AudioAssetList[mLucuList.indexOf(lucu)]() as Sound).play();
			
			var offset:Number = 1024 / (mTemplate.AudioAssetList.length + 0.2);
			var index:int = mLucuList.indexOf(lucu);
			var lamp:Bitmap = new Asset.LampOnBitmap[index]();
			lamp.x = ((index + 0.5) * offset) - (lamp.width / 2);
			lamp.y = 340 - (lamp.height / 2);
			addChildAt(lamp, getChildIndex(mLampList[index]));
			removeChild(mLampList[index]);
			mLampList[index] = lamp;
		}
		
		private function OnRollOutLucu(aEvent:MouseEvent):void
		{
			if (!contains(mBlocker) && !mSuccessFeedback)
			{
				var lucu:Sprite = aEvent.currentTarget as Sprite;
				lucu.transform.colorTransform = new ColorTransform(0.4, 0.4, 0.4);
				
				var offset:Number = 1024 / (mTemplate.AudioAssetList.length + 0.2);
				var index:int = mLucuList.indexOf(lucu);
				var lamp:Bitmap = new Asset.LampOffBitmap[index]();
				lamp.x = ((index + 0.5) * offset) - (lamp.width / 2);
				lamp.y = 340 - (lamp.height / 2);
				addChildAt(lamp, getChildIndex(mLampList[index]));
				removeChild(mLampList[index]);
				mLampList[index] = lamp;
			}
		}
		
		private function OnClickLucu(aEvent:MouseEvent):void
		{
			addChild(mBlocker);
			
			mAnswer = mLucuList.indexOf(aEvent.currentTarget as Sprite);
			(new Asset.ClickSound() as Sound).play();
			
			mResult = (mAnswer == mTemplate.Answer ? Result.GREAT : Result.WRONG);
			
			mValidateAnswerTimer.reset();
			mValidateAnswerTimer.start();
		}
		
		private function OnValidateAnswerTimerComplete(aEvent:TimerEvent):void
		{
			mValidateAnswerTimer.reset();
			
			var endi:int = mTemplate.AudioAssetList.length;
			var colorTransform:ColorTransform = new ColorTransform(0.4, 0.4, 0.4);
			var offset:Number = 1024 / (endi + 0.2);
			var lamp:Bitmap;
			for (var i:int = 0; i < endi; ++i)
			{
				if (mResult == Result.WRONG || i != mTemplate.Answer)
				{
					lamp = new Asset.LampOffBitmap[i]();
					lamp.x = ((i + 0.5) * offset) - (lamp.width / 2);
					lamp.y = 340 - (lamp.height / 2);
					addChildAt(lamp, getChildIndex(mLampList[i]));
					removeChild(mLampList[i]);
					mLampList[i] = lamp;
					
					mLucuList[i].transform.colorTransform = colorTransform;
				}
			}
			
			if (mResult == Result.GREAT)
			{
				(new Asset.CrescendoSound() as Sound).play();
				mShowFeedbackTimer.reset();
				mShowFeedbackTimer.start();
			}
			else
			{
				(new Asset.ErrorSound() as Sound).play();
				mShowAnswerTimer.reset();
				mShowAnswerTimer.start();
			}
		}
		
		private function OnShowAnswerTimerComplete(aEvent:TimerEvent):void
		{
			mShowAnswerTimer.reset();
			
			var offset:Number = 1024 / (mTemplate.AudioAssetList.length + 0.2);
			var lamp:Bitmap = new Asset.LampOnBitmap[mTemplate.Answer]();
			lamp.x = ((mTemplate.Answer + 0.5) * offset) - (lamp.width / 2);
			lamp.y = 340 - (lamp.height / 2);
			addChildAt(lamp, getChildIndex(mLampList[mTemplate.Answer]));
			removeChild(mLampList[mTemplate.Answer]);
			mLampList[mTemplate.Answer] = lamp;
			
			mLucuList[mTemplate.Answer].transform.colorTransform = new ColorTransform();
			
			(new mTemplate.AudioAssetList[mTemplate.Answer] as Sound).play();
			
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