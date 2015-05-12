package com.frimastudio.fj_curriculumassociates_edu.rpt_sentenceunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.Piece;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.SentenceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.UIButton;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.globalization.StringTools;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class WordDraggingDemo extends Sprite
	{
		private static const FORMAT:TextFormat = new TextFormat(null, 24);
		private static const OFFSET:Number = 10;
		
		private var mLayout:Sprite;
		private var mChallengePicture:Sprite;
		private var mBlueBulb:Sprite;
		private var mYellowBulb:Sprite;
		private var mRedBulb:Sprite;
		private var mSentenceTray:SentenceTray;
		private var mPieceTray:PieceTray;
		private var mDraggedPiece:Piece;
		private var mPreviousPosition:Piece;
		private var mSubmit:UIButton;
		private var mSubmitedSentence:UIButton;
		private var mSuccessFeedback:Sprite;
		private var mWin:Boolean;
		
		public function WordDraggingDemo()
		{
			super();
			
			mLayout = new Sprite();
			mLayout.graphics.lineStyle(1, 0xCCCCCC);
			mLayout.graphics.drawRect(200, 100, 400, 220);
			mLayout.graphics.drawRect(118.5, 377.5, 563, 55);
			mLayout.graphics.drawRect(118.5, 440, 496, 55);
			addChild(mLayout);
			
			mChallengePicture = new Sprite();
			mChallengePicture.x = 205;
			mChallengePicture.y = 105;
			mChallengePicture.addChild(new Asset.TheFieldIsOnAHillBitmap() as Bitmap);
			addChild(mChallengePicture);
			
			mBlueBulb = new Sprite();
			mBlueBulb.x = 627.5;
			mBlueBulb.y = 125;
			addChild(mBlueBulb);
			
			mYellowBulb = new Sprite();
			mYellowBulb.x = 625;
			mYellowBulb.y = 162.5;
			addChild(mYellowBulb);
			
			mRedBulb = new Sprite();
			mRedBulb.x = 625;
			mRedBulb.y = 197.5;
			addChild(mRedBulb);
			
			ResetBulb();
			
			mSentenceTray = new SentenceTray(false);
			mSentenceTray.x = 113.5;
			mSentenceTray.y = 405;
			mSentenceTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedSentenceTray);
			addChild(mSentenceTray);
			
			mPieceTray = new PieceTray(false, new <String>["field", "hill", "on", "sun", "is", "the", "a"]);
			mPieceTray.x = 113.5;
			mPieceTray.y = 467.5;
			mPieceTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreedPieceTray);
			addChild(mPieceTray);
			
			mSubmit = new UIButton("√", 0xCCCCCC);
			mSubmit.x = 648.5;
			mSubmit.y = 405;
			mSubmit.addEventListener(MouseEvent.CLICK, OnClickSubmit);
			addChild(mSubmit);
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
		
		private function OnPieceFreedSentenceTray(aEvent:PieceTrayEvent):void
		{
			if (aEvent.Dragged)
			{
				mPreviousPosition = aEvent.EventPiece.NextPiece;
				
				mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Content, new Point(mouseX, mouseY));
				mDraggedPiece.y = mSentenceTray.y;
				addChild(mDraggedPiece);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
				stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
				
				mSubmit.Color = (mSentenceTray.AssembleSentence().length > 0 ? 0xAAFF99 : 0xCCCCCC);
			}
			else
			{
				mPieceTray.InsertLast(aEvent.EventPiece.Content, new Point(mouseX - mPieceTray.x, mouseY - mPieceTray.y));
				
				mSubmit.Color = (mSentenceTray.AssembleSentence().length > 0 ? 0xAAFF99 : 0xCCCCCC);
			}
			
			mSentenceTray.Remove(aEvent.EventPiece);
		}
		
		private function OnPieceFreedPieceTray(aEvent:PieceTrayEvent):void
		{
			if (aEvent.Dragged)
			{
				mPreviousPosition = aEvent.EventPiece.NextPiece;
				
				mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Content, new Point(mouseX, mouseY));
				mDraggedPiece.y = mPieceTray.y;
				addChild(mDraggedPiece);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
				stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			}
			else
			{
				mSentenceTray.InsertLast(aEvent.EventPiece.Content, new Point(mouseX - mSentenceTray.x, mouseY - mSentenceTray.y));
				
				mSubmit.Color = 0xAAFF99;
			}
			
			mPieceTray.Remove(aEvent.EventPiece);
		}
		
		private function OnMouseMoveStage(aEvent:MouseEvent):void
		{
			mDraggedPiece.Position = new Point(mouseX, mouseY);
			
			if (Math.abs(mDraggedPiece.y - mSentenceTray.y) <= Math.abs(mDraggedPiece.y - mPieceTray.y))
			{
				mSentenceTray.MakePlace(mDraggedPiece);
				mPieceTray.FreePlace();
			}
			else
			{
				mSentenceTray.FreePlace();
				mPieceTray.MakePlace(mDraggedPiece);
			}
		}
		
		private function OnMouseUpStage(aEvent:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			if (Math.abs(mDraggedPiece.y - mSentenceTray.y) <= Math.abs(mDraggedPiece.y - mPieceTray.y))
			{
				mSentenceTray.addEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedSentenceTray);
				mSentenceTray.Insert(mDraggedPiece, mPreviousPosition);
				
				mSubmit.Color = 0xAAFF99;
			}
			else
			{
				mPieceTray.addEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedPieceTray);
				mPieceTray.Insert(mDraggedPiece, mPreviousPosition);
			}
		}
		
		private function OnPieceCapturedSentenceTray(aEvent:PieceTrayEvent):void
		{
			mSentenceTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedSentenceTray);
			
			removeChild(aEvent.EventPiece);
			if (aEvent.EventPiece == mDraggedPiece)
			{
				mDraggedPiece = null;
			}
		}
		
		private function OnPieceCapturedPieceTray(aEvent:PieceTrayEvent):void
		{
			mPieceTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCapturedPieceTray);
			
			removeChild(aEvent.EventPiece);
			if (aEvent.EventPiece == mDraggedPiece)
			{
				mDraggedPiece = null;
			}
		}
		
		private function OnClickSubmit(aEvent:MouseEvent):void
		{
			var sentence:String = mSentenceTray.AssembleSentence();
			if (!sentence.length)
			{
				return;
			}
			
			mSubmitedSentence = new UIButton(sentence, 0x99EEFF);
			mSubmitedSentence.x = mSentenceTray.Center;
			mSubmitedSentence.y = mSentenceTray.y;
			mSubmitedSentence.width = mSentenceTray.width;
			addChild(mSubmitedSentence);
			TweenLite.to(mSubmitedSentence, 0.5, { ease:Strong.easeIn, onComplete:OnTweenSquashSubmitedSentence, scaleX:1 } );
			
			mSentenceTray.visible = false;
		}
		
		private function OnTweenSquashSubmitedSentence():void
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
			
			switch (mSubmitedSentence.Content)
			{
				case "The field is on a hill.":
				case "A field is on the hill.":
					mWin = true;
					successLabel.text = "YOU WIN!\n\nCLICK TO\nCONTINUE";
					successLabel.setTextFormat(new TextFormat(null, 40, 0x99EEFF, true, null, null, null, null, "center"));
					
					(new Asset.CrescendoSound() as Sound).play();
					
					mBlueBulb.graphics.clear();
					mBlueBulb.graphics.lineStyle(2, 0x99EEFF);
					mBlueBulb.graphics.beginFill(0x99EEFF);
					mBlueBulb.graphics.drawCircle(-7.5, -7.5, 15);
					mBlueBulb.graphics.endFill();
					
					mSubmitedSentence.Color = 0xAAFF99;
					break;
				case "The hill is on a field.":
				case "A hill is on the field.":
				case "The sun is on a hill.":
				case "A sun is on the hill.":
				case "The sun is on a field.":
				case "A sun is on the field.":
				case "The field is on a sun.":
				case "A field is on the sun.":
				case "The hill is on a sun.":
				case "A hill is on the sun.":
				case "The hill is a field.":
				case "A hill is the field.":
				case "The sun is a hill.":
				case "A sun is the hill.":
				case "The sun is a field.":
				case "A sun is the field.":
				case "The field is a sun.":
				case "A field is the sun.":
				case "The hill is a sun.":
				case "A hill is the sun.":
					successLabel.text = "NICE SENTENCE!\n\nCLICK TO\nCONTINUE";
					successLabel.setTextFormat(new TextFormat(null, 40, 0xFFEE99, true, null, null, null, null, "center"));
					
					(new Asset.ValidationSound() as Sound).play();
					
					mYellowBulb.graphics.clear();
					mYellowBulb.graphics.lineStyle(2, 0xFFEE99);
					mYellowBulb.graphics.beginFill(0xFFEE99);
					mYellowBulb.graphics.drawCircle(-6.75, -6.75, 12.5);
					mYellowBulb.graphics.endFill();
					
					mSubmitedSentence.Color = 0xFFEE99;
					break;
				default:
					successLabel.text = "TRY AGAIN!\n\nCLICK TO\nCONTINUE";
					successLabel.setTextFormat(new TextFormat(null, 40, 0xFF99AA, true, null, null, null, null, "center"));
					
					(new Asset.ErrorSound() as Sound).play();
					
					mRedBulb.graphics.clear();
					mRedBulb.graphics.lineStyle(2, 0xFF99AA);
					mRedBulb.graphics.beginFill(0xFF99AA);
					mRedBulb.graphics.drawCircle(-6.75, -6.75, 12.5);
					mRedBulb.graphics.endFill();
					
					mSubmitedSentence.Color = 0xFF99AA;
					break;
			}
			
			successLabel.x = 400 - (successLabel.width / 2);
			successLabel.y = 300 - (successLabel.height / 2);
			mSuccessFeedback.addChild(successLabel);
			
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, alpha:1 } );
		}
		
		private function OnClickSuccessFeedback(aEvent:MouseEvent):void
		{
			mSuccessFeedback.removeEventListener(MouseEvent.CLICK, OnClickSuccessFeedback);
			
			TweenLite.to(mSuccessFeedback, 0.5, { ease:Strong.easeOut, onComplete:OnTweenHideSuccessFeedback, alpha:0 } );
			
			ResetBulb();
			
			if (mWin)
			{
				mSentenceTray.Clear();
				mPieceTray.Clear(new <String>["field", "hill", "on", "sun", "is", "the", "a"]);
				
				mSubmit.Color = 0xCCCCCC;
				
				mWin = false;
			}
			
			TweenLite.to(mSubmitedSentence, 0.5, { ease:Strong.easeOut, onComplete:OnTweenDisappearSubmitedSentence, alpha:0 });
			
			mSentenceTray.visible = true;
		}
		
		private function OnTweenDisappearSubmitedSentence():void
		{
			mSubmitedSentence.Dispose();
			removeChild(mSubmitedSentence);
			mSubmitedSentence = null;
		}
		
		private function OnTweenHideSuccessFeedback():void
		{
			removeChild(mSuccessFeedback);
			mSuccessFeedback = null;
		}
	}
}