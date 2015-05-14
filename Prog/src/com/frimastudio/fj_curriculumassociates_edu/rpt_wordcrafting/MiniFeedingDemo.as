package com.frimastudio.fj_curriculumassociates_edu.rpt_wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dictionary.WordDictionary;
	import com.frimastudio.fj_curriculumassociates_edu.Mini;
	import com.frimastudio.fj_curriculumassociates_edu.ui.DecayingButton;
	import com.frimastudio.fj_curriculumassociates_edu.ui.DecayingButtonEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.Piece;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.util.MathUtil;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Sine;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class MiniFeedingDemo extends Sprite
	{
		private static const FORMAT:TextFormat = new TextFormat(null, 24);
		private static const OFFSET:Number = 10;
		private static const ANSWER_SPACE:String = "____";
		private static const INSTRUCTION:String = "I need to " + ANSWER_SPACE + " up this cup.";
		
		private var mLayout:Sprite;
		private var mWordLabel:TextField;
		private var mLetterLabel:TextField;
		private var mChunkLabel:TextField;
		private var mCup:Sprite;
		private var mListenHint:UIButton;
		private var mInstruction:TextField;
		private var mInstructionSlot:UIButton;
		private var mWordButtonList:Vector.<UIButton>;
		private var mDraggedWord:UIButton;
		private var mWordMini:WordMini;
		private var mSelectedMini:Mini;
		private var mPieceButtonList:Vector.<DecayingButton>;
		private var mDraggedPieceButton:DecayingButton;
		private var mLetterPieceList:Vector.<UIButton>;
		private var mChunkPieceList:Vector.<UIButton>;
		private var mTray:PieceTray;
		private var mDraggedPiece:Piece;
		private var mListenCrafting:UIButton;
		private var mSubmit:UIButton;
		private var mSubmitedWord:UIButton;
		private var mRedBulb:Sprite;
		private var mYellowBulb:Sprite;
		private var mBlueBulb:Sprite;
		private var mSuccessFeedback:Sprite;
		private var mWin:Boolean;
		private var mState:MiniFeedingDemoState;
		private var mProgressFeedbackTimer:Timer;
		private var mInstructionDisplayTimer:Timer;
		
		public function MiniFeedingDemo()
		{
			super();
			
			mLayout = new Sprite();
			mLayout.graphics.lineStyle(1, 0xCCCCCC);
			mLayout.graphics.drawRect(5, 5, 790, 60);
			mLayout.graphics.drawRect(5, 110, 110, 420);
			mLayout.graphics.drawRect(545, 135, 250, 195);
			mLayout.graphics.drawRect(545, 335, 250, 195);
			mLayout.graphics.drawRect(5, 535, 790, 60);
			addChild(mLayout);
			
			mWordLabel = new TextField();
			mWordLabel.autoSize = TextFieldAutoSize.LEFT;
			mWordLabel.text = "Words";
			mWordLabel.setTextFormat(FORMAT);
			mWordLabel.selectable = false;
			mWordLabel.x = 10;
			mWordLabel.y = 110;
			addChild(mWordLabel);
			
			mLetterLabel = new TextField();
			mLetterLabel.autoSize = TextFieldAutoSize.LEFT;
			mLetterLabel.text = "Letters";
			mLetterLabel.setTextFormat(FORMAT);
			mLetterLabel.selectable = false;
			mLetterLabel.x = 550;
			mLetterLabel.y = 135;
			addChild(mLetterLabel);
			
			mChunkLabel = new TextField();
			mChunkLabel.autoSize = TextFieldAutoSize.LEFT;
			mChunkLabel.text = "Chunks of word";
			mChunkLabel.setTextFormat(FORMAT);
			mChunkLabel.selectable = false;
			mChunkLabel.x = 550;
			mChunkLabel.y = 335;
			addChild(mChunkLabel);
			
			mCup = new Sprite();
			mCup.x = 100;
			mCup.y = 55;
			mCup.scaleX = 0.01;
			mCup.scaleY = 0.01;
			mCup.graphics.lineStyle(2);
			mCup.graphics.beginFill(0xFFFFFF);
			mCup.graphics.moveTo(-50, -50);
			mCup.graphics.lineTo(50, -50);
			mCup.graphics.curveTo(50, 50, 20, 50);
			mCup.graphics.lineTo(-20, 50);
			mCup.graphics.curveTo(-50, 50, -50, -50);
			mCup.graphics.endFill();
			mCup.graphics.moveTo(-50, -25);
			mCup.graphics.curveTo(-75, -25, -75, 0);
			mCup.graphics.curveTo(-75, 25, -42.5, 25);
			mCup.graphics.moveTo(-50, -20);
			mCup.graphics.curveTo(-70, -20, -70, 0);
			mCup.graphics.curveTo(-70, 20, -43.5, 20);
			addChild(mCup);
			
			TweenLite.to(mCup, 1, { ease:Bounce.easeOut, onComplete:OnTweenPopCup, scaleX:1, scaleY:1 });
			
			mListenHint = new UIButton("?", 0xFFEE99);
			mListenHint.x = 180;
			mListenHint.y = 35;
			mListenHint.addEventListener(MouseEvent.CLICK, OnClickListenHint);
			addChild(mListenHint);
			
			mInstructionDisplayTimer = new Timer(42, INSTRUCTION.length);
			mInstructionDisplayTimer.addEventListener(TimerEvent.TIMER, OnInstructionDisplayTimer);
			mInstructionDisplayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionDisplayTimerComplete);
			
			mInstruction = new TextField();
			mInstruction.autoSize = TextFieldAutoSize.LEFT;
			mInstruction.text = "";
			mInstruction.selectable = false;
			mInstruction.x = 210;
			mInstruction.y = 20;
			addChild(mInstruction);
			
			mWordMini = new WordMini();
			mWordMini.x = 340;
			mWordMini.y = 435;
			mWordMini.rotation = -5;
			mWordMini.addEventListener(MouseEvent.CLICK, OnClickWordMini);
			addChild(mWordMini);
			
			TweenLite.to(mWordMini, 6, { ease:Sine.easeInOut, onComplete:OnTweenMoveMiniBack, x:360, rotation:5 });
			
			mWordButtonList = new Vector.<UIButton>();
			CreateWordButton("hill");
			CreateWordButton("felt");
			CreateWordButton("hall");
			CreateWordButton("clam");
			CreateWordButton("leaf");
			CreateWordButton("surf");
			CreateWordButton("fair");
			
			mPieceButtonList = new Vector.<DecayingButton>();
			mLetterPieceList = new Vector.<UIButton>();
			mChunkPieceList = new Vector.<UIButton>();
			
			mTray = new PieceTray(true);
			mTray.x = 115;
			mTray.y = 565;
			mTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreed);
			addChild(mTray);
			
			mListenCrafting = new UIButton("♫", 0xCCCCCC);
			mListenCrafting.x = 575;
			mListenCrafting.y = 565;
			mListenCrafting.addEventListener(MouseEvent.CLICK, OnClickListenCrafting);
			addChild(mListenCrafting);
			
			mSubmit = new UIButton("√", 0xCCCCCC);
			mSubmit.x = 580 + OFFSET + mListenCrafting.width;
			mSubmit.y = 565;
			mSubmit.addEventListener(MouseEvent.CLICK, OnClickSubmit);
			addChild(mSubmit);
			
			mRedBulb = new Sprite();
			mRedBulb.x = 675;
			mRedBulb.y = 87.5;
			addChild(mRedBulb);
			
			mYellowBulb = new Sprite();
			mYellowBulb.x = 725;
			mYellowBulb.y = 87.5;
			addChild(mYellowBulb);
			
			mBlueBulb = new Sprite();
			mBlueBulb.x = 775;
			mBlueBulb.y = 90;
			addChild(mBlueBulb);
			
			ResetBulb();
			
			mProgressFeedbackTimer = new Timer(4000, 0);
			mProgressFeedbackTimer.addEventListener(TimerEvent.TIMER, OnProgressFeedbackTimer);
			
			ProgressState();
		}
		
		private function ProgressState(aState:MiniFeedingDemoState = null):void
		{
			if (aState)
			{
				mState = aState;
			}
			else if (mState)
			{
				mState = mState.NextState;
			}
			else
			{
				mState = MiniFeedingDemoState.WORD_FEEDING;
			}
			
			mProgressFeedbackTimer.reset();
			mProgressFeedbackTimer.start();
		}
		
		private function CreateWordButton(aWord:String):void
		{
			var button:UIButton = new UIButton(aWord, 0xCC99FF);
			button.x = 60;
			button.y = 160;
			if (mWordButtonList.length)
			{
				button.y = mWordButtonList[mWordButtonList.length - 1].y +
					(mWordButtonList[mWordButtonList.length - 1].height / 2) + OFFSET + (button.height / 2);
			}
			button.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWordButton);
			button.addEventListener(MouseEvent.CLICK, OnClickWordButton);
			addChild(button);
			mWordButtonList.push(button);
		}
		
		private function ClearPieceList():void
		{
			for (var i:int = 0, endi:int = mPieceButtonList.length; i < endi; ++i)
			{
				mPieceButtonList[i].removeEventListener(MouseEvent.CLICK, OnClickPieceButton);
				mPieceButtonList[i].Dispose();
				removeChild(mPieceButtonList[i]);
			}
			mPieceButtonList.splice(0, mPieceButtonList.length);
		}
		
		private function ClearLetterList():void
		{
			for (var i:int = 0, endi:int = mLetterPieceList.length; i < endi; ++i)
			{
				mLetterPieceList[i].removeEventListener(MouseEvent.CLICK, OnClickLetterButton);
				mLetterPieceList[i].Dispose();
				removeChild(mLetterPieceList[i]);
			}
			mLetterPieceList.splice(0, mLetterPieceList.length);
		}
		
		private function ClearChunkList():void
		{
			for (var i:int = 0, endi:int = mChunkPieceList.length; i < endi; ++i)
			{
				mChunkPieceList[i].removeEventListener(MouseEvent.CLICK, OnClickChunkButton);
				mChunkPieceList[i].Dispose();
				removeChild(mChunkPieceList[i]);
			}
			mChunkPieceList.splice(0, mChunkPieceList.length);
		}
		
		private function ResetBulb():void
		{
			mRedBulb.graphics.clear();
			mRedBulb.graphics.lineStyle(2, 0xFF99AA);
			mRedBulb.graphics.drawCircle(-6.75, -6.75, 12.5);
			
			mYellowBulb.graphics.clear();
			mYellowBulb.graphics.lineStyle(2, 0xFFEE99);
			mYellowBulb.graphics.drawCircle(-6.75, -6.75, 12.5);
			
			mBlueBulb.graphics.clear();
			mBlueBulb.graphics.lineStyle(2, 0x99EEFF);
			mBlueBulb.graphics.drawCircle(-7.5, -7.5, 15);
		}
		
		private function OnProgressFeedbackTimer(aEvent:TimerEvent):void
		{
			switch (mState)
			{
				case MiniFeedingDemoState.WORD_FEEDING:
					(Random.FromList(mWordButtonList) as UIButton).CallAttention();
					break;
				case MiniFeedingDemoState.PIECE_SELECTING:
					if (mPieceButtonList.length)
					{
						(Random.FromList(mPieceButtonList) as DecayingButton).CallAttention();
					}
					else
					{
						ProgressState(MiniFeedingDemoState.WORD_FEEDING);
					}
					break;
				case MiniFeedingDemoState.PIECE_USING:
					if (mLetterPieceList.length || mChunkPieceList.length)
					{
						if (!mLetterPieceList.length)
						{
							(Random.FromList(mChunkPieceList) as UIButton).CallAttention();
						}
						else if (!mChunkPieceList.length)
						{
							(Random.FromList(mLetterPieceList) as UIButton).CallAttention();
						}
						else
						{
							if (Random.Bool())
							{
								(Random.FromList(mLetterPieceList) as UIButton).CallAttention();
							}
							else
							{
								(Random.FromList(mChunkPieceList) as UIButton).CallAttention();
							}
						}
					}
					else if (mPieceButtonList.length)
					{
						ProgressState(MiniFeedingDemoState.PIECE_SELECTING);
					}
					else
					{
						ProgressState(MiniFeedingDemoState.WORD_FEEDING);
					}
					break;
				case MiniFeedingDemoState.PIECE_SORTING:
					if (mTray.AssembleWord().length)
					{
						mTray.CallAttention();
						ProgressState(MiniFeedingDemoState.WORD_SUBMITTING);
					}
					else if (mLetterPieceList.length || mChunkPieceList.length)
					{
						ProgressState(MiniFeedingDemoState.PIECE_USING);
					}
					else if (mPieceButtonList.length)
					{
						ProgressState(MiniFeedingDemoState.PIECE_SELECTING);
					}
					else
					{
						ProgressState(MiniFeedingDemoState.WORD_FEEDING);
					}
					break;
				case MiniFeedingDemoState.WORD_SUBMITTING:
					if (mTray.AssembleWord().length)
					{
						mSubmit.CallAttention();
					}
					else if (mLetterPieceList.length || mChunkPieceList.length)
					{
						ProgressState(MiniFeedingDemoState.PIECE_USING);
					}
					else if (mPieceButtonList.length)
					{
						ProgressState(MiniFeedingDemoState.PIECE_SELECTING);
					}
					else
					{
						ProgressState(MiniFeedingDemoState.WORD_FEEDING);
					}
					break;
				case null:
					throw new Error("State is null!");
					return;
				default:
					throw new Error("State " + mState.Description + " is not handled.");
					return;
			}
		}
		
		private function OnInstructionDisplayTimer(aEvent:TimerEvent):void
		{
			mInstruction.text = INSTRUCTION.substr(0, mInstructionDisplayTimer.currentCount);
			mInstruction.setTextFormat(FORMAT);
		}
		
		private function OnInstructionDisplayTimerComplete(aEvent:TimerEvent):void
		{
			mInstructionDisplayTimer.reset();
			
			mInstruction.text = INSTRUCTION;
			mInstruction.setTextFormat(FORMAT);
			
			var leftBound:Rectangle = mInstruction.getCharBoundaries(mInstruction.text.indexOf(ANSWER_SPACE));
			var rightBound:Rectangle = mInstruction.getCharBoundaries(mInstruction.text.indexOf(ANSWER_SPACE) + (ANSWER_SPACE.length - 1));
			var target:Point = new Point(mInstruction.x, mInstruction.y);
			target.x += (leftBound.left + rightBound.right) / 2;
			target.y += (Math.min(leftBound.top, rightBound.top) + Math.max(leftBound.bottom, rightBound.bottom)) / 2;
			
			mInstructionSlot = new UIButton("__");
			mInstructionSlot.x = target.x;
			mInstructionSlot.y = target.y;
			mInstructionSlot.scaleX = 0.01;
			mInstructionSlot.scaleY = 0.01;
			addChild(mInstructionSlot);
			
			TweenLite.to(mInstructionSlot, 1, { ease:Elastic.easeOut, scaleX:1, scaleY:1 });
		}
		
		private function OnTweenPopCup():void
		{
			mInstructionDisplayTimer.start();
		}
		
		private function OnTweenMoveMiniBack():void
		{
			TweenLite.to(mWordMini, 6, { ease:Sine.easeInOut, onComplete:OnTweenMoveMiniForward, x:340, rotation:-5 });
		}
		
		private function OnTweenMoveMiniForward():void
		{
			TweenLite.to(mWordMini, 6, { ease:Sine.easeInOut, onComplete:OnTweenMoveMiniBack, x:360, rotation:5 });
		}
		
		private function OnClickListenHint(aEvent:MouseEvent):void
		{
			(new Asset.InstructionSound() as Sound).play();
		}
		
		private function OnClickWordMini(aEvent:MouseEvent):void
		{
			if (mSelectedMini)
			{
				mSelectedMini.Unselect();
			}
			
			mSelectedMini = (mSelectedMini == mWordMini ? null : mWordMini);
			
			if (mSelectedMini)
			{
				mSelectedMini.Select();
				
				TweenLite.to(mSelectedMini, 0.5, { ease:Quad.easeOut, onComplete:OnTweenJumpMini,
					onCompleteParams:[mSelectedMini], y:335 });
			}
		}
		
		private function OnTweenJumpMini(aMini:Mini):void
		{
			TweenLite.to(aMini, 0.7, { ease:Bounce.easeOut, y:435 });
		}
		
		private function OnMouseDownWordButton(aEvent:MouseEvent):void
		{
			if (mDraggedWord)
			{
				return;
			}
			
			mDraggedWord = aEvent.currentTarget as UIButton;
			addChild(mDraggedWord);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStageWord);
		}
		
		private function OnMouseMoveStageWord(aEvent:MouseEvent):void
		{
			mDraggedWord.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWordButton);
			mDraggedWord.removeEventListener(MouseEvent.CLICK, OnClickWordButton);
			
			if (!stage.hasEventListener(MouseEvent.MOUSE_UP))
			{
				stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStageWord);
			}
			
			TweenLite.to(mDraggedWord, 0.5, { ease:Strong.easeOut, overwrite:true, x:mouseX, y:mouseY });
		}
		
		private function OnMouseUpStageWord(aEvent:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStageWord);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStageWord);
			
			TweenLite.to(mDraggedWord, 0.5, { ease:Strong.easeOut, overwrite:true, x:mouseX, y:mouseY });
			
			if (mouseX >= mWordMini.x - (OFFSET + mDraggedWord.width) &&
				mouseX <= mWordMini.x + (OFFSET + mDraggedWord.width) &&
				mouseY >= mWordMini.y + 15 - (OFFSET + mDraggedWord.height) &&
				mouseY <= mWordMini.y + 15 + (OFFSET + mDraggedWord.height))
			{
				TweenLite.to(mDraggedWord, 0.6, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenFeedWord,
					onCompleteParams:[mDraggedWord, mWordMini.CraftWord(mDraggedWord.Content)],
					x:mWordMini.x, y:mWordMini.y + 15 } );
				
				mDraggedWord = null;
			}
			else if (mouseX >= mTray.x - (OFFSET + mDraggedWord.width) &&
				mouseX <= mTray.x + mTray.width + (OFFSET + mDraggedWord.width) &&
				mouseY >= mTray.y - (OFFSET + mDraggedWord.height) &&
				mouseY <= mTray.y + mTray.width + (OFFSET + mDraggedWord.height))
			{
				while (mTray.width + OFFSET + mDraggedWord.width > 410)
				{
					mTray.RemoveFirst();
				}
				
				TweenLite.to(mDraggedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendWord, onCompleteParams:[mDraggedWord],
					x:mTray.NextSlotPosition + (mDraggedWord.width / 2), y:mTray.y });
				
				mDraggedWord = null;
			}
			else
			{
				var index:int = mWordButtonList.indexOf(mDraggedWord);
				var target:Point = new Point(60, 160 + (index * (OFFSET + mDraggedWord.height)));
				
				TweenLite.to(mDraggedWord, 0.5, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenSpawnWord,
					onCompleteParams:[mDraggedWord], x:target.x, y:target.y });
				
				mDraggedWord = null;
			}
		}
		
		private function OnClickWordButton(aEvent:MouseEvent):void
		{
			if (aEvent.currentTarget as UIButton != mDraggedWord)
			{
				return;
			}
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStageWord);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStageWord);
			
			mDraggedWord.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWordButton);
			mDraggedWord.removeEventListener(MouseEvent.CLICK, OnClickWordButton);
			
			if (mSelectedMini)
			{
				switch (mSelectedMini)
				{
					case mWordMini:
						TweenLite.to(mDraggedWord, 0.6, { ease:Strong.easeOut, onComplete:OnTweenFeedWord,
							onCompleteParams:[mDraggedWord, mWordMini.CraftWord(mDraggedWord.Content)],
							x:mSelectedMini.x, y:mSelectedMini.y + 15 } );
						break;
					default:
						throw new Error("Mini not handled!");
						break;
				}
				
				mDraggedWord = null;
			}
			else
			{
				while (mTray.width + OFFSET + mDraggedWord.width > 410)
				{
					mTray.RemoveFirst();
				}
				
				TweenLite.to(mDraggedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendWord, onCompleteParams:[mDraggedWord],
					x:mTray.NextSlotPosition + (mDraggedWord.width / 2), y:mTray.y });
				
				mDraggedWord = null;
			}
			
			(new Asset.SlideSound() as Sound).play();
		}
		
		private function OnTweenFeedWord(aDraggedWord:UIButton, aPieceStringList:Vector.<String>):void
		{
			TweenLite.to(aDraggedWord, 0.2, { ease:Quad.easeOut, onComplete:OnTweenEatWord,
				onCompleteParams:[aDraggedWord, aPieceStringList], alpha:0 });
		}
		
		private function OnTweenEatWord(aDraggedWord:UIButton, aPieceStringList:Vector.<String>):void
		{
			ProgressState(MiniFeedingDemoState.PIECE_SELECTING);
			
			var index:int = mWordButtonList.indexOf(aDraggedWord);
			aDraggedWord.x = 60;
			aDraggedWord.y = 160 + (index * (OFFSET + aDraggedWord.height));
			
			TweenLite.to(aDraggedWord, 0.5, { ease:Strong.easeOut, delay:1, onComplete:OnTweenSpawnWord,
				onCompleteParams:[aDraggedWord], alpha:1 });
			
			var button:DecayingButton;
			var pieceDecayTimer:Timer;
			var target:Point = new Point(350, 100);
			for (var i:int = 0, endi:int = aPieceStringList.length; i < endi; ++i)
			{
				button = new DecayingButton(aPieceStringList[i], 5000, 0xFFFFFF);
				button.x = mWordMini.x;
				button.y = mWordMini.y;
				button.alpha = 0;
				
				if (mPieceButtonList.length)
				{
					target.y += (mPieceButtonList[mPieceButtonList.length - 1].height / 2) + OFFSET + (button.height / 2);
				}
				
				TweenLite.to(button, 0.2, { ease:Strong.easeOut, delay:(i * 0.2), alpha:1 });
				TweenLite.to(button, 3, { ease:Strong.easeOut, delay:(i * 0.2), x:(target.x + Random.Range(-150, 150)) });
				TweenLite.to(button, 5, { ease:Strong.easeOut, delay:(i * 0.2), onComplete:OnTweenSlidePieceUp,
					onCompleteParams:[button], y:target.y });
				
				button.addEventListener(DecayingButtonEvent.DECAY_COMPLETE, OnDecayCompletePiece);
				button.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownPieceButton);
				button.addEventListener(MouseEvent.CLICK, OnClickPieceButton);
				addChild(button);
				mPieceButtonList.push(button);
			}
		}
		
		private function OnTweenSendWord(aDraggedWord:UIButton):void
		{
			ProgressState(MiniFeedingDemoState.PIECE_SORTING);
			
			mTray.Add(aDraggedWord.Content, aDraggedWord.x - mTray.x);
			
			mSubmit.Color = 0xAAFF99;
			
			var index:int = mWordButtonList.indexOf(aDraggedWord);
			
			aDraggedWord.alpha = 0;
			aDraggedWord.x = 60;
			aDraggedWord.y = 160 + (index * (OFFSET + aDraggedWord.height));
			
			TweenLite.to(aDraggedWord, 0.5, { ease:Strong.easeOut, delay:1, onComplete:OnTweenSpawnWord,
				onCompleteParams:[aDraggedWord], alpha:1 } );
		}
		
		private function OnTweenSpawnWord(aDraggedWord:UIButton):void
		{
			aDraggedWord.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownWordButton);
			aDraggedWord.addEventListener(MouseEvent.CLICK, OnClickWordButton);
			
			if (mDraggedWord == aDraggedWord)
			{
				mDraggedWord = null;
			}
		}
		
		private function OnTweenSlidePieceUp(aButton:DecayingButton):void
		{
			aButton.StartDecay();
		}
		
		private function OnDecayCompletePiece(aEvent:DecayingButtonEvent):void
		{
			var button:UIButton = aEvent.currentTarget as UIButton;
			
			button.removeEventListener(DecayingButtonEvent.DECAY_COMPLETE, OnDecayCompletePiece);
			button.removeEventListener(MouseEvent.CLICK, OnClickPieceButton);
			button.Dispose();
			mPieceButtonList.splice(mPieceButtonList.indexOf(button), 1);
			
			TweenLite.to(button, 0.5, { ease:Strong.easeOut, onComplete:OnTweenDisappearDecayedPiece,
				onCompleteParams:[button], alpha:0 });
		}
		
		private function OnTweenDisappearDecayedPiece(aButton:DecayingButton):void
		{
			removeChild(aButton);
		}
		
		private function OnMouseDownPieceButton(aEvent:MouseEvent):void
		{
			mDraggedPieceButton = aEvent.currentTarget as DecayingButton;
			mDraggedPieceButton.StopDecay();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStagePieceButton);
		}
		
		private function OnMouseMoveStagePieceButton(aEvent:MouseEvent):void
		{
			mDraggedPieceButton.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownPieceButton);
			mDraggedPieceButton.removeEventListener(MouseEvent.CLICK, OnClickPieceButton);
			
			if (!stage.hasEventListener(MouseEvent.MOUSE_UP))
			{
				stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStagePieceButton);
			}
			
			TweenLite.to(mDraggedPieceButton, 0.5, { ease:Strong.easeOut, overwrite:true, x:mouseX, y:mouseY });
		}
		
		private function OnMouseUpStagePieceButton(aEvent:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStagePieceButton);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStagePieceButton);
			
			if (mouseX >= 545 && mouseX <= 795 && mouseY >= 135 && mouseY <= 540)
			{
				// send to proper box
			}
			else if (mouseX >= mTray.x - (OFFSET + mDraggedPieceButton.width) &&
				mouseX <= mTray.x + mTray.width + (OFFSET + mDraggedPieceButton.width) &&
				mouseY >= mTray.y - (OFFSET + mDraggedPieceButton.height) &&
				mouseY <= mTray.y + mTray.width + (OFFSET + mDraggedPieceButton.height))
			{
				// send directly to tray
			}
			else
			{
				TweenLite.to(mDraggedPieceButton, 0.5, { ease:Strong.easeOut, overwrite:true,
					onComplete:OnTweenReplaceLoosePieceButton, onCompleteParams:[mDraggedPieceButton],
					x:MathUtil.MinMax(mDraggedPieceButton.x, 160, 500), y:MathUtil.MinMax(mDraggedPieceButton.y, 100, 320) });
			}
			
			mDraggedPieceButton = null;
		}
		
		private function OnTweenReplaceLoosePieceButton(aDraggedPieceButton:DecayingButton):void
		{
			aDraggedPieceButton.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownPieceButton);
			aDraggedPieceButton.addEventListener(MouseEvent.CLICK, OnClickPieceButton);
			aDraggedPieceButton.StartDecay();
		}
		
		private function OnClickPieceButton(aEvent:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStagePieceButton);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStagePieceButton);
			
			var piece:String = mDraggedPieceButton.Content;
			var position:Point = new Point(mDraggedPieceButton.x, mDraggedPieceButton.y);
			
			mDraggedPieceButton.removeEventListener(DecayingButtonEvent.DECAY_COMPLETE, OnDecayCompletePiece);
			mDraggedPieceButton.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownPieceButton);
			mDraggedPieceButton.removeEventListener(MouseEvent.CLICK, OnClickPieceButton);
			mDraggedPieceButton.Dispose();
			removeChild(mDraggedPieceButton);
			mPieceButtonList.splice(mPieceButtonList.indexOf(mDraggedPieceButton), 1);
			
			mDraggedPieceButton = null;
			
			var targetList:Vector.<UIButton>;
			var button:UIButton = new UIButton(piece, 0xCC99FF);
			button.x = position.x;
			button.y = position.y;
			
			var target:Point = new Point(600, 0);
			var limitReached:Boolean;
			if (piece.length == 1)
			{
				target.y = 185;
				targetList = mLetterPieceList;
				button.addEventListener(MouseEvent.CLICK, OnClickLetterButton);
				limitReached = (targetList.length >= 8);
			}
			else
			{
				target.y = 385;
				targetList = mChunkPieceList;
				button.addEventListener(MouseEvent.CLICK, OnClickChunkButton);
				limitReached = (targetList.length >= 6);
			}
			
			var slideTarget:Point = new Point(600, piece.length == 1 ? 185 : 385);
			if (limitReached)
			{
				targetList[0].removeEventListener(MouseEvent.CLICK, (piece.length == 1 ? OnClickLetterButton : OnClickChunkButton));
				TweenLite.to(targetList[0], 0.2, { ease:Strong.easeIn, onComplete:OnTweenEliminatePiece,
					onCompleteParams:[targetList[0]], alpha:0 } );
				targetList.shift();
				
				for (var i:int = 0, endi:int = targetList.length; i < endi; ++i)
				{
					if (i > 0)
					{
						slideTarget.x += (targetList[i - 1].width / 2) + OFFSET + (targetList[i].width / 2);
						if (slideTarget.x + (targetList[i].width / 2) >= 785)
						{
							slideTarget.x = 600;
							slideTarget.y += (targetList[i - 1].height / 2) + OFFSET + (targetList[i].height / 2);
						}
					}
					
					TweenLite.to(targetList[i], 0.2, { ease:Strong.easeOut, x:slideTarget.x, y:slideTarget.y });
				}
			}
			
			if (targetList.length)
			{
				if (limitReached)
				{
					target.x = slideTarget.x + (targetList[targetList.length - 1].width / 2) +
						OFFSET + (button.width / 2);
					target.y = slideTarget.y;
					if (target.x + (button.width / 2) >= 785)
					{
						target.x = 600;
						target.y = slideTarget.y + (targetList[targetList.length - 1].height / 2) +
							OFFSET + (button.height / 2);
					}
				}
				else
				{
					target.x = targetList[targetList.length - 1].x + (targetList[targetList.length - 1].width / 2) +
						OFFSET + (button.width / 2);
					target.y = targetList[targetList.length - 1].y;
					if (target.x + (button.width / 2) >= 785)
					{
						target.x = 600;
						target.y = targetList[targetList.length - 1].y + (targetList[targetList.length - 1].height / 2) +
							OFFSET + (button.height / 2);
					}
				}
			}
			
			targetList.push(button);
			
			TweenLite.to(button, 0.5, { ease:Strong.easeOut, onComplete:OnTweenPieceSelected, x:target.x, y:target.y } );
			
			(new Asset.SlideSound() as Sound).play();
			
			addChild(button);
		}
		
		private function OnTweenEliminatePiece(aPiece:UIButton):void
		{
			aPiece.Dispose();
			removeChild(aPiece);
		}
		
		private function OnTweenPieceSelected():void
		{
			ProgressState(MiniFeedingDemoState.PIECE_USING);
		}
		
		private function OnClickLetterButton(aEvent:MouseEvent):void
		{
			var button:UIButton = aEvent.currentTarget as UIButton;
			
			while (mTray.width + OFFSET + button.width > 410)
			{
				mTray.RemoveFirst();
			}
			
			mLetterPieceList.splice(mLetterPieceList.indexOf(button), 1);
			button.removeEventListener(MouseEvent.CLICK, OnClickLetterButton);
			TweenLite.to(button, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendLetter,
				onCompleteParams:["{self}"], x:mTray.NextSlotPosition + (button.width / 2), y:mTray.y } );
			
			(new Asset.SlideSound() as Sound).play();
			
			var slideTarget:Point = new Point(600, 185);
			for (var i:int = 0, endi:int = mLetterPieceList.length; i < endi; ++i)
			{
				if (i > 0)
				{
					slideTarget.x += (mLetterPieceList[i - 1].width / 2) + OFFSET + (mLetterPieceList[i].width / 2);
					if (slideTarget.x + (mLetterPieceList[i].width / 2) >= 785)
					{
						slideTarget.x = 600;
						slideTarget.y += (mLetterPieceList[i - 1].height / 2) + OFFSET + (mLetterPieceList[i].height / 2);
					}
				}
				
				TweenLite.to(mLetterPieceList[i], 0.2, { ease:Strong.easeOut, x:slideTarget.x, y:slideTarget.y });
			}
		}
		
		private function OnClickChunkButton(aEvent:MouseEvent):void
		{
			var button:UIButton = aEvent.currentTarget as UIButton;
			
			while (mTray.width + OFFSET + button.width > 450)
			{
				mTray.RemoveFirst();
			}
			
			mChunkPieceList.splice(mChunkPieceList.indexOf(button), 1);
			button.removeEventListener(MouseEvent.CLICK, OnClickChunkButton);
			TweenLite.to(button, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendChunk,
				onCompleteParams:["{self}"], x:mTray.NextSlotPosition + (button.width / 2), y:mTray.y } );
			
			(new Asset.SlideSound() as Sound).play();
			
			var slideTarget:Point = new Point(600, 385);
			for (var i:int = 0, endi:int = mChunkPieceList.length; i < endi; ++i)
			{
				if (i > 0)
				{
					slideTarget.x += (mChunkPieceList[i - 1].width / 2) + OFFSET + (mChunkPieceList[i].width / 2);
					if (slideTarget.x + (mChunkPieceList[i].width / 2) >= 785)
					{
						slideTarget.x = 600;
						slideTarget.y += (mChunkPieceList[i - 1].height / 2) + OFFSET + (mChunkPieceList[i].height / 2);
					}
				}
				
				TweenLite.to(mChunkPieceList[i], 0.2, { ease:Strong.easeOut, x:slideTarget.x, y:slideTarget.y });
			}
		}
		
		private function OnTweenSendLetter(aTween:TweenLite):void
		{
			ProgressState(MiniFeedingDemoState.PIECE_SORTING);
			
			var letter:UIButton = aTween.target as UIButton;
			mTray.Add(letter.Content, letter.x - mTray.x);
			letter.Dispose();
			removeChild(letter);
			
			mSubmit.Color = 0xAAFF99;
		}
		
		private function OnTweenSendChunk(aTween:TweenLite):void
		{
			ProgressState(MiniFeedingDemoState.PIECE_SORTING);
			
			var chunk:UIButton = aTween.target as UIButton;
			mTray.Add(chunk.Content, chunk.x - mTray.x);
			chunk.Dispose();
			removeChild(chunk);
			
			mSubmit.Color = 0xAAFF99;
		}
		
		private function OnPieceFreed(aEvent:PieceTrayEvent):void
		{
			mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Content, new Point(mouseX, mouseY));
			addChild(mDraggedPiece);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			mTray.Remove(aEvent.EventPiece);
			
			mSubmit.Color = (mTray.AssembleWord().length ? 0xAAFF99 : 0xCCCCCC);
		}
		
		private function OnMouseMoveStage(aEvent:MouseEvent):void
		{
			mDraggedPiece.Position = new Point(mouseX, mouseY);
			mTray.MakePlace(mDraggedPiece);
		}
		
		private function OnMouseUpStage(aEvent:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			mTray.addEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCaptured);
			mTray.Insert(mDraggedPiece);
			
			mSubmit.Color = (mTray.AssembleWord().length ? 0xAAFF99 : 0xCCCCCC);
		}
		
		private function OnPieceCaptured(aEvent:PieceTrayEvent):void
		{
			mTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCaptured);
			
			aEvent.EventPiece.Dispose();
			removeChild(aEvent.EventPiece);
			if (aEvent.EventPiece == mDraggedPiece)
			{
				mDraggedPiece = null;
			}
			
			mSubmit.Color = (mTray.AssembleWord().length ? 0xAAFF99 : 0xCCCCCC);
		}
		
		private function OnClickListenCrafting(aMouseEvent:MouseEvent):void
		{
		}
		
		private function OnClickSubmit(aEvent:MouseEvent):void
		{
			var word:String = mTray.AssembleWord();
			if (!word.length)
			{
				return;
			}
			
			mInstruction.text = INSTRUCTION;
			mInstruction.setTextFormat(FORMAT);
			
			ResetBulb();
			
			mSubmitedWord = new UIButton(word, 0x99EEFF);
			mSubmitedWord.x = mTray.Center;
			mSubmitedWord.y = mTray.y;
			mSubmitedWord.width = mTray.width;
			addChild(mSubmitedWord);
			TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeIn, onComplete:OnTweenSquashSubmitedWord, scaleX:1 } );
			
			mTray.Clear();
			
			mSubmit.Color = 0xCCCCCC;
			
			if (mLetterPieceList.length || mChunkPieceList.length)
			{
				ProgressState(MiniFeedingDemoState.PIECE_USING);
			}
			else if (mPieceButtonList.length)
			{
				ProgressState(MiniFeedingDemoState.PIECE_SELECTING);
			}
			else
			{
				ProgressState(MiniFeedingDemoState.WORD_FEEDING);
			}
		}
		
		private function OnTweenSquashSubmitedWord():void
		{
			if (WordDictionary.Validate(mSubmitedWord.Content, 1))
			{
				TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenStretchSubmitedWord, scaleX:1.5, scaleY:1.5 } );
			}
			else
			{
				mRedBulb.graphics.clear();
				mRedBulb.graphics.lineStyle(2, 0xFF99AA);
				mRedBulb.graphics.beginFill(0xFF99AA);
				mRedBulb.graphics.drawCircle(-6.75, -6.75, 12.5);
				mRedBulb.graphics.endFill();
				
				(new Asset.ErrorSound() as Sound).play();
				
				mSubmitedWord.Color = 0xFF99AA;
				
				TweenLite.to(mSubmitedWord, 1, { ease:Strong.easeOut, onComplete:OnTweenDisappearSubmitedWord, alpha:0 });
				
				mSuccessFeedback = new Sprite();
				mSuccessFeedback.addEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
				mSuccessFeedback.graphics.beginFill(0x000000, 0);
				mSuccessFeedback.graphics.drawRect(0, 0, 800, 600);
				mSuccessFeedback.graphics.endFill();
				mSuccessFeedback.alpha = 0;
				addChild(mSuccessFeedback);
				
				var successLabel:TextField = new TextField();
				successLabel.autoSize = TextFieldAutoSize.CENTER;
				successLabel.selectable = false;
				successLabel.filters = [new DropShadowFilter(1.5, 45, 0x000000, 1, 2, 2, 3, BitmapFilterQuality.HIGH)];
				successLabel.text = "TRY AGAIN!\n\nCLICK TO\nCONTINUE";
				successLabel.setTextFormat(new TextFormat(null, 40, 0xFF99AA, true, null, null, null, null, "center"));
				successLabel.x = 400 - (successLabel.width / 2);
				successLabel.y = 300 - (successLabel.height / 2);
				mSuccessFeedback.addChild(successLabel);
				
				TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, alpha:1 } );
			}
		}
		
		private function OnTweenStretchSubmitedWord():void
		{
			TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendSubmitedWord,
				x:mInstructionSlot.x, y:mInstructionSlot.y, scaleX:1, scaleY:1 } );
			
			(new Asset.SlideSound() as Sound).play();
		}
		
		private function OnTweenSendSubmitedWord():void
		{
			mSuccessFeedback = new Sprite();
			mSuccessFeedback.addEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			mSuccessFeedback.graphics.beginFill(0x000000, 0);
			mSuccessFeedback.graphics.drawRect(0, 0, 800, 600);
			mSuccessFeedback.graphics.endFill();
			mSuccessFeedback.alpha = 0;
			addChild(mSuccessFeedback);
			
			var successLabel:TextField = new TextField();
			successLabel.autoSize = TextFieldAutoSize.CENTER;
			successLabel.selectable = false;
			successLabel.filters = [new DropShadowFilter(1.5, 45, 0x000000, 1, 2, 2, 3, BitmapFilterQuality.HIGH)];
			
			if (mSubmitedWord.Content == "fill")
			{
				mBlueBulb.graphics.clear();
				mBlueBulb.graphics.lineStyle(2, 0x99EEFF);
				mBlueBulb.graphics.beginFill(0x99EEFF);
				mBlueBulb.graphics.drawCircle(-7.5, -7.5, 15);
				mBlueBulb.graphics.endFill();
				
				(new Asset.InstructionSound() as Sound).play();
				
				successLabel.text = "YOU WIN!\n\nCLICK TO\nCONTINUE";
				successLabel.setTextFormat(new TextFormat(null, 40, 0x99EEFF, true, null, null, null, null, "center"));
				
				mWin = true;
			}
			else
			{
				mYellowBulb.graphics.clear();
				mYellowBulb.graphics.lineStyle(2, 0xFFEE99);
				mYellowBulb.graphics.beginFill(0xFFEE99);
				mYellowBulb.graphics.drawCircle(-6.75, -6.75, 12.5);
				mYellowBulb.graphics.endFill();
				
				(new Asset.ValidationSound() as Sound).play();
				
				successLabel.text = "GREAT WORD!\nBUT IT DOES NOT WORK\nIN THIS SENTENCE\n\nCLICK TO\nCONTINUE";
				successLabel.setTextFormat(new TextFormat(null, 40, 0xFFEE99, true, null, null, null, null, "center"));
				
				TweenLite.to(mSubmitedWord, 1, { ease:Strong.easeOut, onComplete:OnTweenDisappearSubmitedWord, alpha:0 });
			}
			
			successLabel.x = 400 - (successLabel.width / 2);
			successLabel.y = 300 - (successLabel.height / 2);
			mSuccessFeedback.addChild(successLabel);
			
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, alpha:1 });
		}
		
		private function OnClickSuccessFeedback(aEvent:MouseEvent):void
		{
			mSuccessFeedback.removeEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSuccessFeedback, alpha:0 } );
			
			ResetBulb();
			
			if (mWin)
			{
				ClearPieceList();
				ClearLetterList();
				ClearChunkList();
				mTray.Clear();
				
				mInstruction.text = "";
				mInstructionDisplayTimer.reset();
				
				(new Asset.CrescendoSound() as Sound).play();
				
				mCup.scaleX = 0.01;
				mCup.scaleY = 0.01;
				TweenLite.to(mCup, 1, { ease:Bounce.easeOut, onComplete:OnTweenPopCup, scaleX:1, scaleY:1 });
				
				removeChild(mInstructionSlot);
				mInstructionSlot = null;
				
				TweenLite.to(mSubmitedWord, 1, { ease:Strong.easeOut, onComplete:OnTweenDisappearSubmitedWord, alpha:0 });
				
				mWin = false;
			}
		}
		
		private function OnTweenDisappearSubmitedWord():void
		{
			mSubmitedWord.Dispose();
			removeChild(mSubmitedWord);
			mSubmitedWord = null;
		}
		
		private function OnTweenHideSuccessFeedback():void
		{
			removeChild(mSuccessFeedback);
			mSuccessFeedback = null;
		}
	}
}