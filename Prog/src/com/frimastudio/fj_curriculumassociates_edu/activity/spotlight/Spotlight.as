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
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
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
	
	public class Spotlight extends Activity
	{
		private var mTemplate:SpotlightTemplate;
		private var mLampList:Vector.<Bitmap>;
		private var mLucuList:Vector.<Sprite>;
		private var mEarBtnList:Vector.<Box>;
		private var mResult:Result;
		private var mBlocker:Sprite;
		private var mSuccessFeedback:Sprite;
		private var mEarAudioTimer:Timer;
		private var mValidateAnswerTimer:Timer;
		private var mShowAnswerTimer:Timer;
		private var mShowFeedbackTimer:Timer;
		
		public function Spotlight(aTemplate:SpotlightTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			var endi:int = mTemplate.AudioAssetList.length;
			var i:int;
			var offset:Number = 1024 / (endi + 0.2);
			
			var background:Sprite = new Sprite();
			background.graphics.beginFill(Palette.CRAFTING_BOX);
			background.graphics.drawRect(0, 0, 1024, 768);
			addChild(background);
			
			mLampList = new Vector.<Bitmap>();
			var lamp:Bitmap;
			for (i = 0; i < endi; ++i)
			{
				lamp = new Asset.LampOffBitmap[i]();
				lamp.x = ((i + 0.5) * offset) - (lamp.width / 2);
				lamp.y = 340 - (lamp.height / 2);
				addChild(lamp);
				mLampList.push(lamp);
			}
			
			var colorTransform:ColorTransform = new ColorTransform(0.4, 0.4, 0.4);
			mLucuList = new Vector.<Sprite>();
			var lucu:Sprite;
			var lucuPicture:Bitmap;
			for (i = 0; i < endi; ++i)
			{
				lucu = new Sprite();
				lucuPicture = new Asset.LucuBitmap();
				lucuPicture.x = -lucuPicture.width / 2;
				lucuPicture.y = -lucuPicture.height / 2;
				lucu.addChild(lucuPicture);
				lucu.x = (i + 0.5) * offset;
				lucu.y = 475;
				lucu.transform.colorTransform = colorTransform;
				lucu.addEventListener(MouseEvent.CLICK, OnClickLucu);
				addChild(lucu);
				mLucuList.push(lucu);
			}
			
			mEarBtnList = new Vector.<Box>();
			var earBtn:Box;
			for (i = 0; i < endi; ++i)
			{
				earBtn = new Box(new Point(76, 66), Palette.DIALOG_BOX,
					new BoxIcon(Asset.IconEarBitmap, Palette.DIALOG_CONTENT), 12, Direction.DOWN);
				earBtn.x = ((i + 0.5) * offset) - 85;
				earBtn.y = 275;
				earBtn.addEventListener(MouseEvent.CLICK, OnClickEarBtn);
				mEarBtnList.push(earBtn);
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
			addChild(mBlocker);
			
			mEarAudioTimer = new Timer(700, endi + 1);
			mEarAudioTimer.addEventListener(TimerEvent.TIMER, OnEarAudioTimer);
			mEarAudioTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarAudioTimerComplete);
			
			mValidateAnswerTimer = new Timer(700, 1);
			mValidateAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnValidateAnswerTimerComplete);
			
			mShowAnswerTimer = new Timer(700, 1);
			mShowAnswerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnShowAnswerTimerComplete);
			
			mShowFeedbackTimer = new Timer(700, 1);
			mShowFeedbackTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnShowFeedbackTimerComplete);
			
			mEarAudioTimer.reset();
			mEarAudioTimer.start();
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnEarAudioTimer(aEvent:TimerEvent):void
		{
			var offset:Number = 1024 / (mTemplate.AudioAssetList.length + 0.2);
			var lamp:Bitmap;
			var index:int = mEarAudioTimer.currentCount - 1;
			if (index > 0)
			{
				lamp = new Asset.LampOffBitmap[index - 1]();
				lamp.x = ((index - 1 + 0.5) * offset) - (lamp.width / 2);
				lamp.y = 340 - (lamp.height / 2);
				addChildAt(lamp, getChildIndex(mLampList[index - 1]));
				removeChild(mLampList[index - 1]);
				mLampList[index - 1] = lamp;
				
				mLucuList[index - 1].transform.colorTransform = new ColorTransform(0.4, 0.4, 0.4);
			}
			if (index < mTemplate.AudioAssetList.length)
			{
				(new mTemplate.AudioAssetList[index]() as Sound).play();
				
				lamp = new Asset.LampOnBitmap[index]();
				lamp.x = ((index + 0.5) * offset) - (lamp.width / 2);
				lamp.y = 340 - (lamp.height / 2);
				addChildAt(lamp, getChildIndex(mLampList[index]));
				removeChild(mLampList[index]);
				mLampList[index] = lamp;
				
				mLucuList[index].transform.colorTransform = new ColorTransform();
			}
		}
		
		private function OnEarAudioTimerComplete(aEvent:TimerEvent):void
		{
			mEarAudioTimer.reset();
			
			var endi:int = mTemplate.AudioAssetList.length;
			var offset:Number = 1024 / (endi + 0.2);
			var lamp:Bitmap;
			for (var i:int = 0; i < endi; ++i)
			{
				lamp = new Asset.LampOnBitmap[i]();
				lamp.x = ((i + 0.5) * offset) - (lamp.width / 2);
				lamp.y = 340 - (lamp.height / 2);
				addChildAt(lamp, getChildIndex(mLampList[i]));
				removeChild(mLampList[i]);
				mLampList[i] = lamp;
				
				mLucuList[i].transform.colorTransform = new ColorTransform();
				
				addChild(mEarBtnList[i]);
			}
			
			removeChild(mBlocker);
		}
		
		private function OnClickEarBtn(aEvent:MouseEvent):void
		{
			var index:int = mEarBtnList.indexOf(aEvent.currentTarget as Box);
			(new mTemplate.AudioAssetList[index]() as Sound).play();
		}
		
		private function OnClickLucu(aEvent:MouseEvent):void
		{
			addChild(mBlocker);
			
			var index:int = mLucuList.indexOf(aEvent.currentTarget as Sprite);
			(new mTemplate.AudioAssetList[index]() as Sound).play();
			
			for (var i:int = 0, endi:int = mEarBtnList.length; i < endi; ++i)
			{
				removeChild(mEarBtnList[i]);
			}
			
			mResult = (index == mTemplate.Answer ? Result.GREAT : Result.WRONG);
			
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
			mSuccessFeedback.removeEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			removeChild(mSuccessFeedback);
			mSuccessFeedback = null;
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}