package com.frimastudio.fj_curriculumassociates_edu.rpt_wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.Piece;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.UIButton;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class MiniFeedingDemo extends Sprite
	{
		private static const FORMAT:TextFormat = new TextFormat(null, 24);
		private static const OFFSET:Number = 10;
		
		private var mCup:Sprite;
		private var mInstruction:TextField;
		private var mWordButtonList:Vector.<UIButton>;
		private var mMini:WordMini;
		private var mPieceButtonList:Vector.<UIButton>;
		private var mTray:PieceTray;
		private var mDraggedPiece:Piece;
		private var mSubmit:UIButton;
		private var mSubmitedWord:UIButton;
		
		public function MiniFeedingDemo()
		{
			super();
			
			mCup = new Sprite();
			mCup.x = 250;
			mCup.y = 100;
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
			
			mInstruction = new TextField();
			mInstruction.autoSize = TextFieldAutoSize.LEFT;
			mInstruction.text = "I need to ____ up this cup.";
			mInstruction.setTextFormat(FORMAT);
			mInstruction.selectable = false;
			mInstruction.x = 350;
			mInstruction.y = 80;
			addChild(mInstruction);
			
			mWordButtonList = new Vector.<UIButton>();
			CreateWordButton("hill");
			CreateWordButton("felt");
			CreateWordButton("hall");
			CreateWordButton("spin");
			CreateWordButton("trap");
			CreateWordButton("damp");
			CreateWordButton("honk");
			
			mMini = new WordMini();
			mMini.x = 400;
			mMini.y = 350;
			mMini.addEventListener(WordMiniEvent.BURP_PIECE, OnBurpPieceMini);
			addChild(mMini);
			
			mPieceButtonList = new Vector.<UIButton>();
			
			mTray = new PieceTray(true);
			mTray.x = 280;
			mTray.y = 525;
			mTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreed);
			addChild(mTray);
			
			//mSubmit = new UIButton("√", 0xAAFF99);
			mSubmit = new UIButton("√", 0xCCCCCC);
			mSubmit.x = 520;
			mSubmit.y = 525;
			mSubmit.addEventListener(MouseEvent.CLICK, OnClickSubmit);
			addChild(mSubmit);
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
			button.y = 250;
			button.addEventListener(MouseEvent.CLICK, OnClickWordButton);
			addChild(button);
			mWordButtonList.push(button);
		}
		
		private function ClearPieceList():void
		{
			for (var i:int = 0, endi:int = mPieceButtonList.length; i < endi; ++i)
			{
				mPieceButtonList[i].removeEventListener(MouseEvent.CLICK, OnClickPieceButton);
				removeChild(mPieceButtonList[i]);
			}
			mPieceButtonList.splice(0, mPieceButtonList.length);
		}
		
		private function OnClickWordButton(aEvent:MouseEvent):void
		{
			ClearPieceList();
			
			mMini.EatWord((aEvent.currentTarget as UIButton).Content);
		}
		
		private function OnBurpPieceMini(aEvent:WordMiniEvent):void
		{
			var button:UIButton;
			for (var i:int = 0, endi:int = aEvent.PieceList.length; i < endi; ++i)
			{
				button = new UIButton(aEvent.PieceList[i], 0xFFFFFF);
				button.x = 350;
				if (mPieceButtonList.length)
				{
					button.x = mPieceButtonList[mPieceButtonList.length - 1].x +
						(mPieceButtonList[mPieceButtonList.length - 1].width / 2) + OFFSET + (button.width / 2);
				}
				button.y = 450;
				button.addEventListener(MouseEvent.CLICK, OnClickPieceButton);
				addChild(button);
				mPieceButtonList.push(button);
			}
		}
		
		private function OnClickPieceButton(aEvent:MouseEvent):void
		{
			var button:UIButton = aEvent.currentTarget as UIButton;
			mTray.Add(button.Content);
			
			mSubmit.Color = 0xAAFF99;
			
			button.removeEventListener(MouseEvent.CLICK, OnClickPieceButton);
			removeChild(button);
			mPieceButtonList.splice(mPieceButtonList.indexOf(button), 1);
		}
		
		private function OnPieceFreed(aEvent:PieceTrayEvent):void
		{
			mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Content, mouseX);
			mDraggedPiece.y = mTray.y;
			addChild(mDraggedPiece);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			mTray.Remove(aEvent.EventPiece);
			
			mSubmit.Color = (mTray.AssembleWord().length ? 0xAAFF99 : 0xCCCCCC);
		}
		
		private function OnMouseMoveStage(aEvent:MouseEvent):void
		{
			mDraggedPiece.Position = mouseX;
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
			
			mSubmitedWord = new UIButton(word, 0x99EEFF);
			mSubmitedWord.x = mTray.Center;
			mSubmitedWord.y = mTray.y;
			mSubmitedWord.width = mTray.width;
			addChild(mSubmitedWord);
			TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeIn, onComplete:OnTweenSquashSubmitedWord, scaleX:1 } );
			
			mTray.Clear();
			
			mSubmit.Color = 0xCCCCCC;
			
			ClearPieceList();
		}
		
		private function OnTweenSquashSubmitedWord():void
		{
			TweenLite.to(mSubmitedWord, 0.5, { ease:Elastic.easeOut, onComplete:OnTweenCenterSubmitedWord, x:400 });
		}
		
		private function OnTweenCenterSubmitedWord():void
		{
			if (mSubmitedWord.Content == "fill")
			{
				mSubmitedWord.Color = 0xAAFF99;
				TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenStretchSubmitedWord, scaleX:2, scaleY:2 } );
			}
			else
			{
				mSubmitedWord.Color = 0xFF99AA;
				TweenLite.to(mSubmitedWord, 1, { ease:Strong.easeOut, onComplete:OnTweenDisappearSubmitedWord, alpha:0 } );
			}
		}
		
		private function OnTweenStretchSubmitedWord():void
		{
			var leftBound:Rectangle = mInstruction.getCharBoundaries(mInstruction.text.indexOf("____"));
			var rightBound:Rectangle = mInstruction.getCharBoundaries(mInstruction.text.indexOf("____") + 3);
			var target:Point = new Point(mInstruction.x, mInstruction.y);
			target.x += (leftBound.left + rightBound.right) / 2;
			target.y += (Math.min(leftBound.top, rightBound.top) + Math.max(leftBound.bottom, rightBound.bottom)) / 2;
			
			TweenLite.to(mSubmitedWord, 0.5, { ease:Strong.easeOut, onComplete:OnTweenSendSubmitedWord, x:target.x, y:target.y, scaleX:1, scaleY:1 } );
		}
		
		private function OnTweenSendSubmitedWord():void
		{
			mInstruction.text = "I need to " + mSubmitedWord.Content + " up this cup.";
			mInstruction.setTextFormat(FORMAT);
			
			removeChild(mSubmitedWord);
			mSubmitedWord = null;
		}
		
		private function OnTweenDisappearSubmitedWord():void
		{
			removeChild(mSubmitedWord);
			mSubmitedWord = null;
		}
	}
}