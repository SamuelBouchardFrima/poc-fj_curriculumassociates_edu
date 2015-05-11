package com.frimastudio.fj_curriculumassociates_edu.rpt_wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.dictionary.WordDictionary;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.Piece;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.UIButton;
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
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class MiniFeedingDemo extends Sprite
	{
		private static const FORMAT:TextFormat = new TextFormat(null, 24);
		private static const OFFSET:Number = 10;
		private static const INSTRUCTION:String = "I need to __ up this cup.";
		private static const ANSWER_SPACE:String = "__";
		
		private var mLayout:Sprite;
		private var mWordLabel:TextField;
		private var mLetterLabel:TextField;
		private var mChunkLabel:TextField;
		private var mCup:Sprite;
		private var mInstruction:TextField;
		private var mWordButtonList:Vector.<UIButton>;
		private var mMini:WordMini;
		private var mPieceButtonList:Vector.<UIButton>;
		private var mLetterPieceList:Vector.<UIButton>;
		private var mChunkPieceList:Vector.<UIButton>;
		private var mTray:PieceTray;
		private var mDraggedPiece:Piece;
		private var mSubmit:UIButton;
		private var mSubmitedWord:UIButton;
		private var mRedBulb:Sprite;
		private var mYellowBulb:Sprite;
		private var mBlueBulb:Sprite;
		private var mEatenWord:UIButton;
		private var mPieceStringList:Vector.<String>;
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
			mLayout.graphics.drawRect(545, 100, 250, 195);
			mLayout.graphics.drawRect(545, 300, 250, 195);
			mLayout.graphics.drawRect(5, 500, 790, 95);
			addChild(mLayout);
			
			mWordLabel = new TextField();
			mWordLabel.autoSize = TextFieldAutoSize.LEFT;
			mWordLabel.text = "Words";
			mWordLabel.setTextFormat(FORMAT);
			mWordLabel.selectable = false;
			mWordLabel.x = 50;
			mWordLabel.y = 500;
			addChild(mWordLabel);
			
			mLetterLabel = new TextField();
			mLetterLabel.autoSize = TextFieldAutoSize.LEFT;
			mLetterLabel.text = "Letters";
			mLetterLabel.setTextFormat(FORMAT);
			mLetterLabel.selectable = false;
			mLetterLabel.x = 550;
			mLetterLabel.y = 100;
			addChild(mLetterLabel);
			
			mChunkLabel = new TextField();
			mChunkLabel.autoSize = TextFieldAutoSize.LEFT;
			mChunkLabel.text = "Chunks of word";
			mChunkLabel.setTextFormat(FORMAT);
			mChunkLabel.selectable = false;
			mChunkLabel.x = 550;
			mChunkLabel.y = 300;
			addChild(mChunkLabel);
			
			mInstructionDisplayTimer = new Timer(20, INSTRUCTION.length);
			mInstructionDisplayTimer.addEventListener(TimerEvent.TIMER, OnInstructionDisplayTimer);
			mInstructionDisplayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionDisplayTimerComplete);
			
			mInstruction = new TextField();
			mInstruction.autoSize = TextFieldAutoSize.LEFT;
			mInstruction.text = "";
			mInstruction.selectable = false;
			mInstruction.x = 180;
			mInstruction.y = 20;
			addChild(mInstruction);
			
			mCup = new Sprite();
			mCup.x = 100;
			mCup.y = 60;
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
			
			mMini = new WordMini();
			mMini.x = 240;
			mMini.y = 400;
			mMini.rotation = -5;
			addChild(mMini);
			
			TweenLite.to(mMini, 6, { ease:Sine.easeInOut, onComplete:OnTweenMoveMiniBack, x:260, rotation:5 });
			
			mWordButtonList = new Vector.<UIButton>();
			CreateWordButton("hill");
			CreateWordButton("felt");
			CreateWordButton("hall");
			CreateWordButton("spin");
			CreateWordButton("trap");
			CreateWordButton("damp");
			CreateWordButton("honk");
			
			mPieceButtonList = new Vector.<UIButton>();
			mLetterPieceList = new Vector.<UIButton>();
			mChunkPieceList = new Vector.<UIButton>();
			
			mTray = new PieceTray(true);
			mTray.x = 450;
			mTray.y = 35;
			mTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreed);
			addChild(mTray);
			
			mSubmit = new UIButton("√", 0xCCCCCC);
			mSubmit.x = 750;
			mSubmit.y = 35;
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
			button.x = 120;
			if (mWordButtonList.length)
			{
				button.x = mWordButtonList[mWordButtonList.length - 1].x +
					(mWordButtonList[mWordButtonList.length - 1].width / 2) + OFFSET + (button.width / 2);
			}
			button.y = 550;
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
						(Random.FromList(mPieceButtonList) as UIButton).CallAttention();
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
		}
		
		private function OnTweenPopCup():void
		{
			mInstructionDisplayTimer.start();
		}
		
		private function OnTweenMoveMiniBack():void
		{
			TweenLite.to(mMini, 6, { ease:Sine.easeInOut, onComplete:OnTweenMoveMiniForward, x:240, rotation:-5 });
		}
		
		private function OnTweenMoveMiniForward():void
		{
			TweenLite.to(mMini, 6, { ease:Sine.easeInOut, onComplete:OnTweenMoveMiniBack, x:260, rotation:5 });
		}
		
		private function OnClickWordButton(aEvent:MouseEvent):void
		{
			if (mEatenWord)
			{
				return;
			}
			
			mEatenWord = aEvent.currentTarget as UIButton;
			addChild(mEatenWord);
			
			ClearPieceList();
			
			TweenLite.to(mEatenWord, 0.6, { ease:Strong.easeOut, onComplete:OnTweenFeedWord, x:mMini.x, y:mMini.y + 15 });
			
			mPieceStringList = mMini.EatWord(mEatenWord.Content);			
		}
		
		private function OnTweenFeedWord():void
		{
			TweenLite.to(mEatenWord, 0.2, { ease:Quad.easeOut, onComplete:OnTweenEatWord, alpha:0 });
		}
		
		private function OnTweenEatWord():void
		{
			ProgressState(MiniFeedingDemoState.PIECE_SELECTING);
			
			TweenLite.to(mEatenWord, 0.6, { ease:Strong.easeOut, delay:1, onComplete:OnTweenSpawnWord, alpha:1 } );
			
			mEatenWord.x = 120;
			var index:int = mWordButtonList.indexOf(mEatenWord);
			if (index > 0)
			{
				mEatenWord.x = mWordButtonList[index - 1].x + (mWordButtonList[index - 1].width / 2) +
					OFFSET + (mEatenWord.width / 2);
			}
			mEatenWord.y = 550;
			
			var button:UIButton;
			var target:Point = new Point(250, 150);;
			for (var i:int = 0, endi:int = mPieceStringList.length; i < endi; ++i)
			{
				button = new UIButton(mPieceStringList[i], 0xFFFFFF);
				button.x = mMini.x;
				button.y = mMini.y;
				button.alpha = 0;
				
				if (mPieceButtonList.length)
				{
					target.y += (mPieceButtonList[mPieceButtonList.length - 1].height / 2) + OFFSET + (button.height / 2);
				}
				
				TweenLite.to(button, 0.2, { ease:Strong.easeOut, delay:(i * 0.2), alpha:1 });
				TweenLite.to(button, 3, { ease:Strong.easeOut, delay:(i * 0.2), x:(target.x + Random.Range(-150, 150)) });
				TweenLite.to(button, 5, { ease:Strong.easeOut, delay:(i * 0.2), y:target.y });
				
				button.addEventListener(MouseEvent.CLICK, OnClickPieceButton);
				addChild(button);
				mPieceButtonList.push(button);
			}
		}
		
		private function OnTweenSpawnWord():void
		{
			mEatenWord = null;
		}
		
		private function OnClickPieceButton(aEvent:MouseEvent):void
		{
			var button:UIButton = aEvent.currentTarget as UIButton;
			var piece:String = button.Content;
			var position:Point = new Point(button.x, button.y);
			
			button.removeEventListener(MouseEvent.CLICK, OnClickPieceButton);
			button.Dispose();
			removeChild(button);
			mPieceButtonList.splice(mPieceButtonList.indexOf(button), 1);
			
			var targetList:Vector.<UIButton>;
			button = new UIButton(piece, 0xCC99FF);
			button.x = position.x;
			button.y = position.y;
			
			var target:Point = new Point(600, 0);
			var limitReached:Boolean;
			if (piece.length == 1)
			{
				target.y = 150;
				targetList = mLetterPieceList;
				button.addEventListener(MouseEvent.CLICK, OnClickLetterButton);
				limitReached = (targetList.length >= 8);
			}
			else
			{
				target.y = 350;
				targetList = mChunkPieceList;
				button.addEventListener(MouseEvent.CLICK, OnClickChunkButton);
				limitReached = (targetList.length >= 6);
			}
			
			var slideTarget:Point = new Point(600, piece.length == 1 ? 150 : 350);
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
			
			TweenLite.to(button, 0.5, { ease:Strong.easeOut, onComplete:OnTweenPieceSelected, x:target.x, y:target.y });
			
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
			
			while (mTray.width + OFFSET + button.width > 250)
			{
				mTray.RemoveFirst();
			}
			
			mLetterPieceList.splice(mLetterPieceList.indexOf(button), 1);
			button.removeEventListener(MouseEvent.CLICK, OnClickLetterButton);
			TweenLite.to(button, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendLetter,
				onCompleteParams:["{self}"], x:mTray.NextSlotPosition + (button.width / 2), y:mTray.y });
			
			var slideTarget:Point = new Point(600, 150);
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
			
			while (mTray.width + OFFSET + button.width > 250)
			{
				mTray.RemoveFirst();
			}
			
			mChunkPieceList.splice(mChunkPieceList.indexOf(button), 1);
			button.removeEventListener(MouseEvent.CLICK, OnClickChunkButton);
			TweenLite.to(button, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendChunk,
				onCompleteParams:["{self}"], x:mTray.NextSlotPosition + (button.width / 2), y:mTray.y });
			
			var slideTarget:Point = new Point(600, 350);
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
				
				mSubmitedWord.Color = 0xFF99AA;
				TweenLite.to(mSubmitedWord, 1, { ease:Strong.easeOut, onComplete:OnTweenDisappearSubmitedWord, alpha:0 });
				
				mSuccessFeedback = new Sprite();
				mSuccessFeedback.addEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
				mSuccessFeedback.graphics.beginFill(0x000000, 0.5);
				mSuccessFeedback.graphics.drawRect(0, 0, 800, 600);
				mSuccessFeedback.graphics.endFill();
				mSuccessFeedback.alpha = 0;
				addChild(mSuccessFeedback);
				
				var successLabel:TextField = new TextField();
				successLabel.autoSize = TextFieldAutoSize.CENTER;
				successLabel.selectable = false;
				successLabel.text = "TRY AGAIN!\n\nCLICK TO\nCONTINUE";
				successLabel.setTextFormat(new TextFormat(null, 40, 0xFF99AA, true, null, null, null, null, "center"));
				successLabel.x = 400 - (successLabel.width / 2);
				successLabel.y = 300 - (successLabel.height / 2);
				mSuccessFeedback.addChild(successLabel);
				
				TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, alpha:1 });
			}
		}
		
		private function OnTweenStretchSubmitedWord():void
		{
			var leftBound:Rectangle = mInstruction.getCharBoundaries(mInstruction.text.indexOf(ANSWER_SPACE));
			var rightBound:Rectangle = mInstruction.getCharBoundaries(mInstruction.text.indexOf(ANSWER_SPACE) + 1);
			var target:Point = new Point(mInstruction.x, mInstruction.y);
			target.x += (leftBound.left + rightBound.right) / 2;
			target.y += (Math.min(leftBound.top, rightBound.top) + Math.max(leftBound.bottom, rightBound.bottom)) / 2;
			
			TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendSubmitedWord, x:target.x, y:target.y, scaleX:1, scaleY:1 } );
		}
		
		private function OnTweenSendSubmitedWord():void
		{
			mSuccessFeedback = new Sprite();
			mSuccessFeedback.addEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			mSuccessFeedback.graphics.beginFill(0x000000, 0.5);
			mSuccessFeedback.graphics.drawRect(0, 0, 800, 600);
			mSuccessFeedback.graphics.endFill();
			mSuccessFeedback.alpha = 0;
			addChild(mSuccessFeedback);
			
			var successLabel:TextField = new TextField();
			successLabel.autoSize = TextFieldAutoSize.CENTER;
			successLabel.selectable = false;
			
			if (mSubmitedWord.Content == "fill")
			{
				mBlueBulb.graphics.clear();
				mBlueBulb.graphics.lineStyle(2, 0x99EEFF);
				mBlueBulb.graphics.beginFill(0x99EEFF);
				mBlueBulb.graphics.drawCircle(-7.5, -7.5, 15);
				mBlueBulb.graphics.endFill();
				
				mInstruction.text = INSTRUCTION.split(ANSWER_SPACE).join(mSubmitedWord.Content);
				mInstruction.setTextFormat(FORMAT);
				
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
				
				successLabel.text = "NICE WORD!\n\nCLICK TO\nCONTINUE";
				successLabel.setTextFormat(new TextFormat(null, 40, 0xFFEE99, true, null, null, null, null, "center"));
			}
			
			successLabel.x = 400 - (successLabel.width / 2);
			successLabel.y = 300 - (successLabel.height / 2);
			mSuccessFeedback.addChild(successLabel);
			
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, alpha:1 });
			
			mSubmitedWord.Dispose();
			removeChild(mSubmitedWord);
			mSubmitedWord = null;
		}
		
		private function OnTweenDisappearSubmitedWord():void
		{
			mSubmitedWord.Dispose();
			removeChild(mSubmitedWord);
			mSubmitedWord = null;
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
				
				mCup.scaleX = 0.01;
				mCup.scaleY = 0.01;
				TweenLite.to(mCup, 1, { ease:Bounce.easeOut, onComplete:OnTweenPopCup, scaleX:1, scaleY:1 });
				
				mWin = false;
			}
		}
		
		private function OnTweenHideSuccessFeedback():void
		{
			removeChild(mSuccessFeedback);
			mSuccessFeedback = null;
		}
	}
}