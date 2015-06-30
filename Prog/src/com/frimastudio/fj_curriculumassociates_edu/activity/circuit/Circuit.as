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
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
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
		private var mCircuitConnection:Bitmap;
		private var mCircuitList:Vector.<Sprite>;
		private var mWordList:Vector.<CurvedBox>;
		private var mCurrentCircuit:int;
		private var mSlot:CurvedBox;
		private var mAnswer:int;
		private var mAttempt:int;
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
			
			mCircuitConnection = new Asset.CircuitConnection();
			mCircuitConnection.x = 155;
			mCircuitConnection.y = 430;
			addChild(mCircuitConnection);
			
			mCircuitList = new Vector.<Sprite>();
			var circuit:Sprite;
			var circuitBitmap:Bitmap;
			for (i = 0, endi = mTemplate.AnswerList.length; i < endi; ++i)
			{
				circuit = new Sprite();
				circuit.x = (i * 330) + 175;
				circuit.y = 208;
				circuitBitmap = new Asset.CircuitDisabled();
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
					new BoxLabel(mTemplate.WordList[i], 52.5, Palette.DIALOG_CONTENT), 6);
				word.x = ((i % 3) * 220) + 190;
				word.y = (Math.floor(i / 3) * 90) + 620 + 300;
				if (mTemplate.SkipInstruction)
				{
					TweenLite.to(word, 0.5, { ease:Strong.easeOut, delay:(i * 0.1), y:(word.y - 300) });
				}
				else
				{
					TweenLite.to(word, 0.5, { ease:Strong.easeOut, delay:((i * 0.1) + 1.2), y:(word.y - 300) });
				}
				word.addEventListener(MouseEvent.CLICK, OnClickWord);
				word.EnableMouseOver();
				addChild(word);
				mWordList.push(word);
			}
			
			var lucu:Bitmap = new Asset.NewCircuitLucuBitmap();
			lucu.x = 758;
			lucu.y = 508;
			addChild(lucu);
			
			mResultList = new Vector.<Result>();
			
			mBlocker = new Sprite();
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			mBlocker.graphics.beginFill(0x000000, 0);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.graphics.endFill();
			addChild(mBlocker);
			
			mCurrentCircuit = 0;
			
			var startLessonTimer:Timer = new Timer((mTemplate.WordList.length * 100) + 500, 1);
			if (!mTemplate.SkipInstruction)
			{
				var instruction:Sound = new Asset.CircuitInstructionSound() as Sound;
				instruction.play();
				startLessonTimer.delay = Math.max(startLessonTimer.delay, instruction.length);
			}
			startLessonTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnStartLessonTimerComplete);
			startLessonTimer.start();
			
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
			mAttempt = 0;
			
			mCircuitList[mCurrentCircuit].removeChildAt(0);
			var circuitBitmap:Bitmap = new Asset.CircuitOff();
			circuitBitmap.x = -circuitBitmap.width / 2;
			circuitBitmap.y = -circuitBitmap.height / 2;
			mCircuitList[mCurrentCircuit].addChild(circuitBitmap);
			
			var picture:Sprite = new Sprite();
			picture.x = 5;
			picture.y = 30;
			picture.scaleX = picture.scaleY = 0.01;
			var pictureBitmap:Bitmap = new Asset.CircuitBitmap["_" + mTemplate.WordList[mTemplate.AnswerList[mCurrentCircuit]]]();
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
				if (!contains(mWordList[i]))
				{
					if (i == mTemplate.AnswerList[mCurrentCircuit - 1])
					{
						mWordList[i].Content = new BoxLabel(mTemplate.DistractorList[mCurrentCircuit - 1], 52.5,
							Palette.DIALOG_CONTENT);
					}
					mWordList[i].y = (Math.floor(i / 3) * 90) + 620 + 300;
					TweenLite.to(mWordList[i], 0.5, { ease:Strong.easeOut, delay:(i * 0.1), y:(mWordList[i].y - 300) });
					addChild(mWordList[i]);
				}
			}
			
			mSlot = new CurvedBox(new Point(188, 66), 0xFF000000);
			mSlot.x = mCircuitList[mCurrentCircuit].x - 5;
			mSlot.y = mCircuitList[mCurrentCircuit].y + 202;
			var filter:GlowFilter = new GlowFilter(0x00FF99, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH, true);
			mSlot.filters = [filter];
			mSlot.alpha = 0;
			addChild(mSlot);
			TweenLite.to(mSlot, 0.5, { ease:Strong.easeOut, onComplete:OnTweenGlowSlotStronger, alpha:1 } );
			
			(new Asset.CircuitSound["_" + mTemplate.WordList[mTemplate.AnswerList[mCurrentCircuit]]]() as Sound).play();
			
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
		
		private function OnStartLessonTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnStartLessonTimerComplete);
			
			ShowPicture();
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnClickWord(aEvent:MouseEvent):void
		{
			(new Asset.ClickSound() as Sound).play();
			(new Asset.SlideSound() as Sound).play();
			
			++mAttempt;
			
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
			
			var index:int = mTemplate.DistractorList.indexOf(mWordList[mAnswer].Label);
			if (index > -1)
			{
				(new Asset.CircuitSound["_" + mTemplate.DistractorList[index]]() as Sound).play();
			}
			else
			{
				(new Asset.CircuitSound["_" + mTemplate.WordList[mAnswer]]() as Sound).play();
			}
		}
		
		private function OnTweenSendAnswer(aWordBtn:CurvedBox):void
		{
			var answerBtn:CurvedBox = new CurvedBox(aWordBtn.Size, Palette.DIALOG_BOX,
				new BoxLabel(aWordBtn.Label, 52.5, Palette.DIALOG_CONTENT), 6);
			answerBtn.x = aWordBtn.x;
			answerBtn.y = aWordBtn.y;
			addChild(answerBtn);
			addChild(mBlocker);
			
			var btnColor:int;
			if (mAnswer == mTemplate.AnswerList[mCurrentCircuit])
			{
				//(new Asset.CrescendoSound() as Sound).play();
				
				(new (Random.FromList(Asset.PositiveFeedbackSound) as Class)() as Sound).play();
				
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
				var pictureBitmap:Bitmap = new Asset.CircuitBitmap["_" + mTemplate.WordList[mTemplate.AnswerList[mCurrentCircuit]]]();
				pictureBitmap.smoothing = true;
				pictureBitmap.x = -pictureBitmap.width / 2;
				pictureBitmap.y = -pictureBitmap.height / 2;
				picture.addChild(pictureBitmap);
				mCircuitList[mCurrentCircuit].addChild(picture);
			}
			else
			{
				(new Asset.ErrorSound() as Sound).play();
				btnColor = Palette.WRONG_BTN;
				
				
				if (mAttempt < 2)
				{
					TweenLite.to(answerBtn, 0.3, { ease:Quad.easeIn, delay:0.7, onComplete:OnTweenHideWrongAnswer,
						onCompleteParams:[answerBtn], y:825 });
					
					removeChild(mBlocker);
				}
				else
				{
					mResultList.push(Result.WRONG);
					TweenLite.to(answerBtn, 0.5, { delay:0.2, onComplete:OnTweenShowWrongAnswer, onCompleteParams:[answerBtn] });
				}
			}
			answerBtn.BoxColor = btnColor;
			answerBtn.filters = [new GlowFilter(btnColor, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
			
			removeChild(aWordBtn);
			aWordBtn.x = ((mAnswer % 3) * 220) + 190;
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
			
			(new Asset.CircuitSound["_" + mTemplate.WordList[mTemplate.AnswerList[mCurrentCircuit]]]() as Sound).play();
		}
		
		private function OnTweenHideWrongAnswer(aWrongAnswerBtn:CurvedBox):void
		{
			removeChild(aWrongAnswerBtn);
		}
		
		private function OnTweenSendCorrectAnswer(aWordBtn:CurvedBox):void
		{
			var answer:int = mWordList.indexOf(aWordBtn);
			
			var answerBtn:CurvedBox = new CurvedBox(aWordBtn.Size, Palette.DIALOG_BOX,
				new BoxLabel(mTemplate.WordList[mTemplate.AnswerList[mCurrentCircuit]], 52.5, Palette.DIALOG_CONTENT), 6);
			answerBtn.x = aWordBtn.x;
			answerBtn.y = aWordBtn.y;
			addChild(answerBtn);
			TweenLite.to(answerBtn, 0.5, { ease:Elastic.easeOut, onComplete:OnTweenShowAnswer, onCompleteParams:[answerBtn] });
			
			removeChild(aWordBtn);
			aWordBtn.x = ((answer % 3) * 220) + 190;
		}
		
		private function OnTweenShowAnswer(aAnswerBtn:CurvedBox):void
		{
			if (mSlot)
			{
				TweenLite.killTweensOf(mSlot);
				removeChild(mSlot);
			}
			
			++mCurrentCircuit;
			if (mCurrentCircuit < mTemplate.AnswerList.length)
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
				
				for (var i:int = 0, endi:int = mWordList.length; i < endi; ++i)
				{
					mWordList[i].BoxColor = Palette.DIALOG_BOX;
					mWordList[i].filters = [];
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
				TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, delay:1.2,
					onComplete:OnTweenShowSuccessFeedback, alpha:1 });
				
				mSuccessFeedbackAudioTimer.reset();
				mSuccessFeedbackAudioTimer.start();
			}
		}
		
		private function OnSuccessFeedbackAudioTimerComplete(aEvent:TimerEvent):void
		{
			mSuccessFeedbackAudioTimer.reset();
			
			var sound:Sound;
			switch (mResult)
			{
				case Result.GREAT:
					sound = (new Asset.CrescendoSound() as Sound);
					
					var connection:Bitmap = new Asset.CircuitConnectionOn();
					connection.x = 155;
					connection.y = 430;
					addChildAt(connection, getChildIndex(mCircuitConnection));
					removeChild(mCircuitConnection);
					mCircuitConnection = connection;
					break;
				case Result.VALID:
					sound = (new Asset.ValidationSound() as Sound);
					break;
				case Result.WRONG:
					sound = (new Asset.ErrorSound() as Sound);
					break;
			}
			sound.play();
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