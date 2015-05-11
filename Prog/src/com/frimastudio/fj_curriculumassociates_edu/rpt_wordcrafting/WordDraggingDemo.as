package com.frimastudio.fj_curriculumassociates_edu.rpt_wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.Piece;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTray;
	import com.frimastudio.fj_curriculumassociates_edu.ui.piecetray.PieceTrayEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class WordDraggingDemo extends Sprite
	{
		private var mTray:PieceTray;
		private var mDraggedPiece:Piece;
		
		public function WordDraggingDemo()
		{
			super();
			
			mTray = new PieceTray(false, new <String>["field", "hill", "on", "is", "the", "a"]);
			mTray.x = 200;
			mTray.y = 100;
			mTray.addEventListener(PieceTrayEvent.PIECE_FREED, OnPieceFreed);
			addChild(mTray);
		}
		
		private function OnPieceFreed(aEvent:PieceTrayEvent):void
		{
			mDraggedPiece = new Piece(null, null, aEvent.EventPiece.Content, new Point(mouseX, mouseY));
			mDraggedPiece.y = mTray.y;
			addChild(mDraggedPiece);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpStage);
			
			mTray.Remove(aEvent.EventPiece);
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
		}
		
		private function OnPieceCaptured(aEvent:PieceTrayEvent):void
		{
			mTray.removeEventListener(PieceTrayEvent.PIECE_CAPTURED, OnPieceCaptured);
			
			removeChild(aEvent.EventPiece);
			if (aEvent.EventPiece == mDraggedPiece)
			{
				mDraggedPiece = null;
			}
		}
	}
}