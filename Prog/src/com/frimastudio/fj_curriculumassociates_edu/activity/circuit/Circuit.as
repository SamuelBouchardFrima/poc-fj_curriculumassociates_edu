package com.frimastudio.fj_curriculumassociates_edu.activity.circuit
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.Activity;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.Result;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.FontList;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
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
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class Circuit extends Activity
	{
		private var mTemplate:CircuitTemplate;
		private var mCircuitList:Vector.<Sprite>;
		private var mWordList:Vector.<CurvedBox>;
		private var mCurrentCircuit:int;
		private var mSlot:CurvedBox;
		private var mAnswer:int;
		private var mResultList:Vector.<Result>;
		private var mResult:Result;
		private var mBlocker:Sprite;
		private var mSuccessFeedback:Sprite;
		private var mEarWordTimer:Timer;
		private var mEarCorrectWordSlideTimer:Timer;
		private var mEarCorrectWordTimer:Timer;
		private var mSuccessFeedbackAudioTimer:Timer;
		
		public function Circuit(aTemplate:CircuitTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			var i:int, endi:int;
			
			var background:Sprite = new Sprite();
			background.graphics.beginFill(0x666666);
			background.graphics.drawRect(0, 0, 1024, 768);
			background.graphics.endFill();
			addChild(background);
			
			var table:Sprite = new Sprite();
			table.graphics.beginFill(Palette.CRAFTING_BOX);
			table.graphics.moveTo(0, 678);
			table.graphics.lineTo(60, 615);
			table.graphics.lineTo(1024, 615);
			table.graphics.lineTo(1024, 768);
			table.graphics.lineTo(0, 768);
			table.graphics.lineTo(0, 678);
			table.graphics.endFill();
			addChild(table);
			
			var circuitConnection:Bitmap = new Asset.CircuitConnection();
			circuitConnection.x = 155;
			circuitConnection.y = 430;
			addChild(circuitConnection);
			
			mCircuitList = new Vector.<Sprite>();
			var circuit:Sprite;
			var circuitBitmap:Bitmap;
			for (i = 0, endi = mTemplate.PictureAssetList.length; i < endi; ++i)
			{
				circuit = new Sprite();
				circuit.x = (i * 330) + 175;
				circuit.y = 208;
				circuitBitmap = new Asset.CircuitOff();
				circuitBitmap.x = -circuitBitmap.width / 2;
				circuitBitmap.y = -circuitBitmap.height / 2;
				circuit.addChild(circuitBitmap);
				addChild(circuit);
				mCircuitList.push(circuit);
			}
			
			mWordList = new Vector.<CurvedBox>();
			var word:CurvedBox;
			for (i = 0, endi = mTemplate.WordList.length; i < endi; ++i)
			{
				word = new CurvedBox(new Point(188, 66), Palette.DIALOG_BOX,
					new BoxLabel(mTemplate.WordList[i], 52.5, Palette.DIALOG_CONTENT), 12);
				word.x = ((i % 3) * 240) + 190;
				word.y = (Math.floor(i / 3) * 90) + 620 + 300;
				TweenLite.to(word, 0.5, { ease:Strong.easeOut, delay:((i * 0.1) + 1.2), y:(word.y - 300) });
				word.addEventListener(MouseEvent.CLICK, OnClickWord);
				word.EnableMouseOver();
				addChild(word);
				mWordList.push(word);
			}
			
			var lucu:Bitmap = new Asset.CircuitLucuBitmap();
			lucu.x = 788;
			lucu.y = 438;
			addChild(lucu);
			
			mResultList = new Vector.<Result>();
			
			mBlocker = new Sprite();
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			mBlocker.graphics.beginFill(0x000000, 0);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.graphics.endFill();
			addChild(mBlocker);
			
			mCurrentCircuit = 0;
			
			var instruction:Sound = new Asset.CircuitInstructionSound() as Sound;
			instruction.play();
			var instructionTimer:Timer = new Timer(instruction.length, 1);
			instructionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			instructionTimer.start();
			
			mEarWordTimer = new Timer(300, 1);
			mEarWordTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarWordTimerComplete);
			
			mEarCorrectWordSlideTimer = new Timer(300, 1);
			mEarCorrectWordSlideTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarCorrectWordSlideTimerComplete);
			
			mEarCorrectWordTimer = new Timer(600, 1);
			mEarCorrectWordTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarCorrectWordTimerComplete);
			
			mSuccessFeedbackAudioTimer = new Timer(500, 1);
			mSuccessFeedbackAudioTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnSuccessFeedbackAudioTimerComplete);
		}
		
		override public function Dispose():void
		{
			for (var i:int = 0, endi:int = mWordList.length; i < endi; ++i)
			{
				mWordList[i].removeEventListener(MouseEvent.CLICK, OnClickWord);
				mWordList[i].DisableMouseOver();
			}
			
			mBlocker.removeEventListener(MouseEvent.CLICK, OnClickBlocker);
			
			mEarWordTimer.reset();
			mEarWordTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnEarWordTimerComplete);
			
			mEarCorrectWordSlideTimer.reset();
			mEarCorrectWordSlideTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnEarCorrectWordSlideTimerComplete);
			
			mEarCorrectWordTimer.reset();
			mEarCorrectWordTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnEarCorrectWordTimerComplete);
			
			mSuccessFeedbackAudioTimer.reset();
			mSuccessFeedbackAudioTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnSuccessFeedbackAudioTimerComplete);
		}
		
		private function ShowPicture():void
		{
			var picture:Sprite = new Sprite();
			picture.x = 5;
			picture.y = 30;
			picture.scaleX = picture.scaleY = 0.01;
			var pictureBitmap:Bitmap = new mTemplate.PictureAssetList[mCurrentCircuit]();
			pictureBitmap.smoothing = true;
			pictureBitmap.x = -pictureBitmap.width / 2;
			pictureBitmap.y = -pictureBitmap.height / 2;
			picture.addChild(pictureBitmap);
			TweenLite.to(picture, 1, { ease:Elastic.easeOut, scaleX:1, scaleY:1 });
			mCircuitList[mCurrentCircuit].addChild(picture);
			
			for (var i:int = 0, endi:int = mWordList.length; i < endi; ++i)
			{
				mWordList[i].BoxColor = Palette.DIALOG_BOX;
				mWordList[i].filters = [];
			}
			
			mSlot = new CurvedBox(new Point(188, 66), 0xFF000000);
			mSlot.x = mCircuitList[mCurrentCircuit].x - 5;
			mSlot.y = mCircuitList[mCurrentCircuit].y + 202;
			var filter:GlowFilter = new GlowFilter(0x00FF99, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true);
			mSlot.filters = [filter];
			mSlot.alpha = 0;
			addChild(mSlot);
			TweenLite.to(mSlot, 0.5, { ease:Strong.easeOut, onComplete:OnTweenGlowSlotStronger, alpha:1 });
			
			removeChild(mBlocker);
		}
		
		private function OnTweenGlowSlotStronger():void
		{
			TweenLite.to(mSlot, 1, { ease:Quad.easeOut, onComplete:OnTweenGlowSlotWeaker, alpha:0.5 } );
		}
		
		private function OnTweenGlowSlotWeaker():void
		{
			TweenLite.to(mSlot, 1, { ease:Quad.easeOut, onComplete:OnTweenGlowSlotStronger, alpha:1 });
		}
		
		private function OnInstructionTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			
			ShowPicture();
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnClickWord(aEvent:MouseEvent):void
		{
			(new Asset.ClickSound() as Sound).play();
			(new Asset.SlideSound() as Sound).play();
			
			var wordBtn:CurvedBox = aEvent.currentTarget as CurvedBox;
			TweenLite.to(wordBtn, 1, { ease:Elastic.easeOut, onComplete:OnTweenSendAnswer, onCompleteParams:[wordBtn],
				x:(mCircuitList[mCurrentCircuit].x - 5), y:(mCircuitList[mCurrentCircuit].y + 202) } );
			
			mAnswer = mWordList.indexOf(wordBtn);
			
			mEarWordTimer.reset();
			mEarWordTimer.start();
			
			addChild(wordBtn);
			addChild(mBlocker);
		}
		
		private function OnEarWordTimerComplete(aEvent:TimerEvent):void
		{
			mEarWordTimer.reset();
			
			(new mTemplate.AudioAssetList[mAnswer]() as Sound).play();
		}
		
		private function OnTweenSendAnswer(aWordBtn:CurvedBox):void
		{
			var answerBtn:CurvedBox = new CurvedBox(aWordBtn.Size, Palette.DIALOG_BOX,
				new BoxLabel(aWordBtn.Label, 52.5, Palette.DIALOG_CONTENT), 12);
			answerBtn.x = aWordBtn.x;
			answerBtn.y = aWordBtn.y;
			addChild(answerBtn);
			
			var btnColor:int;
			if (mAnswer == mTemplate.AnswerList[mCurrentCircuit])
			{
				(new Asset.CrescendoSound() as Sound).play();
				
				TweenLite.to(answerBtn, 0.5, { onComplete:OnTweenShowAnswer, onCompleteParams:[answerBtn] });
				
				mResultList.push(Result.GREAT);
				btnColor = 0x00FF99;
				
				while (mCircuitList[mCurrentCircuit].numChildren)
				{
					mCircuitList[mCurrentCircuit].removeChildAt(0);
				}
				
				var circuitBitmap:Bitmap = new Asset.CircuitOn();
				circuitBitmap.x = -circuitBitmap.width / 2;
				circuitBitmap.y = -circuitBitmap.height / 2;
				mCircuitList[mCurrentCircuit].addChild(circuitBitmap);
				var picture:Sprite = new Sprite();
				picture.x = 5;
				picture.y = 30;
				var pictureBitmap:Bitmap = new mTemplate.PictureAssetList[mCurrentCircuit]();
				pictureBitmap.smoothing = true;
				pictureBitmap.x = -pictureBitmap.width / 2;
				pictureBitmap.y = -pictureBitmap.height / 2;
				picture.addChild(pictureBitmap);
				mCircuitList[mCurrentCircuit].addChild(picture);
			}
			else
			{
				(new Asset.ErrorSound() as Sound).play();
				
				mResultList.push(Result.WRONG);
				btnColor = Palette.WRONG_BTN;
				
				TweenLite.to(answerBtn, 0.5, { delay:0.2, onComplete:OnTweenShowWrongAnswer, onCompleteParams:[answerBtn] });
			}
			answerBtn.BoxColor = btnColor;
			answerBtn.filters = [new GlowFilter(btnColor, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			
			aWordBtn.alpha = 0;
			aWordBtn.x = ((mAnswer % 3) * 240) + 190;
			aWordBtn.y = (Math.floor(mAnswer / 3) * 90) + 620;
			TweenLite.to(aWordBtn, 1.5, { ease:Strong.easeOut, alpha:1 });
			
			addChild(mBlocker);
		}
		
		private function OnTweenShowWrongAnswer(aWrongAnswerBtn:CurvedBox):void
		{
			TweenLite.to(aWrongAnswerBtn, 0.3, { ease:Quad.easeIn, onComplete:OnTweenHideWrongAnswer,
				onCompleteParams:[aWrongAnswerBtn], y:825 } );
			
			TweenLite.to(mWordList[mTemplate.AnswerList[mCurrentCircuit]], 1, { ease:Elastic.easeOut, delay:0.3,
				onComplete:OnTweenSendCorrectAnswer, onCompleteParams:[mWordList[mTemplate.AnswerList[mCurrentCircuit]]],
				x:(mCircuitList[mCurrentCircuit].x - 5), y:(mCircuitList[mCurrentCircuit].y + 202) });
			
			mEarCorrectWordSlideTimer.reset();
			mEarCorrectWordSlideTimer.start();
			
			mEarCorrectWordTimer.reset();
			mEarCorrectWordTimer.start();
			
			addChild(mWordList[mTemplate.AnswerList[mCurrentCircuit]]);
			addChild(mBlocker);
		}
		
		private function OnEarCorrectWordSlideTimerComplete(aEvent:TimerEvent):void
		{
			mEarCorrectWordSlideTimer.reset();
			
			(new Asset.SlideSound() as Sound).play();
		}
		
		private function OnEarCorrectWordTimerComplete(aEvent:TimerEvent):void
		{
			mEarCorrectWordTimer.reset();
			
			(new mTemplate.AudioAssetList[mTemplate.AnswerList[mCurrentCircuit]]() as Sound).play();
		}
		
		private function OnTweenHideWrongAnswer(aWrongAnswerBtn:CurvedBox):void
		{
			removeChild(aWrongAnswerBtn);
		}
		
		private function OnTweenSendCorrectAnswer(aWordBtn:CurvedBox):void
		{
			var answer:int = mWordList.indexOf(aWordBtn);
			
			var answerBtn:CurvedBox = new CurvedBox(aWordBtn.Size, Palette.DIALOG_BOX,
				new BoxLabel(mTemplate.WordList[mTemplate.AnswerList[mCurrentCircuit]], 52.5, Palette.DIALOG_CONTENT), 12);
			answerBtn.x = aWordBtn.x;
			answerBtn.y = aWordBtn.y;
			addChild(answerBtn);
			TweenLite.to(answerBtn, 0.5, { ease:Elastic.easeOut, onComplete:OnTweenShowAnswer, onCompleteParams:[answerBtn] });
			
			aWordBtn.alpha = 0;
			aWordBtn.x = ((answer % 3) * 240) + 190;
			aWordBtn.y = (Math.floor(answer / 3) * 90) + 620;
			TweenLite.to(aWordBtn, 1.5, { ease:Strong.easeOut, alpha:1 });
		}
		
		private function OnTweenShowAnswer(aAnswerBtn:CurvedBox):void
		{
			if (mSlot)
			{
				TweenLite.killTweensOf(mSlot);
				removeChild(mSlot);
			}
			
			++mCurrentCircuit;
			if (mCurrentCircuit < mTemplate.PictureAssetList.length)
			{
				ShowPicture();
			}
			else
			{
				var wrongIndex:int = mResultList.indexOf(Result.WRONG);
				if (wrongIndex >= 0)
				{
					mResult = (mResultList.indexOf(Result.WRONG, wrongIndex + 1) >= 0 ? Result.WRONG : Result.VALID);
				}
				else
				{
					mResult = Result.GREAT;
				}
				
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
				switch (mResult)
				{
					case Result.GREAT:
						successLabel.text = "Great!\nClick to continue.";
						break;
					case Result.VALID:
						successLabel.text = "Good!\nClick to continue.";
						break;
					case Result.WRONG:
					default:
						successLabel.text = "Almost!\nClick to continue.";
						break;
				}
				successLabel.setTextFormat(new TextFormat(FontList.SEMI_BOLD, 72, mResult.Color,
					null, null, null, null, null, "center"));
				successLabel.x = 512 - (successLabel.width / 2);
				successLabel.y = 384 - (successLabel.height / 2);
				mSuccessFeedback.addChild(successLabel);
				addChild(mSuccessFeedback);
				TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, delay:1.2,
					onComplete:OnTweenShowSuccessFeedback, alpha:1 } );
				
				mSuccessFeedbackAudioTimer.reset();
				mSuccessFeedbackAudioTimer.start();
			}
		}
		
		private function OnSuccessFeedbackAudioTimerComplete(aEvent:TimerEvent):void
		{
			mSuccessFeedbackAudioTimer.reset();
			
			switch (mResult)
			{
				case Result.GREAT:
					(new Asset.CrescendoSound() as Sound).play();
					break;
				case Result.VALID:
					(new Asset.ValidationSound() as Sound).play();
					break;
				case Result.WRONG:
					(new Asset.ErrorSound() as Sound).play();
					break;
			}
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