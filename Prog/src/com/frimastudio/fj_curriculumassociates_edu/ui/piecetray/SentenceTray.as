package com.frimastudio.fj_curriculumassociates_edu.ui.piecetray
{
	import flash.geom.Point;
	
	public class SentenceTray extends PieceTray
	{
		public function SentenceTray(aEnablePieceDelete:Boolean, aContentList:Vector.<String> = null)
		{
			super(aEnablePieceDelete, aContentList);
		}
		
		override public function InsertFirst(aContent:String):void
		{
			if (mFirstPiece)
			{
				mFirstPiece.Content = mFirstPiece.Content.toLowerCase();
			}
			
			super.InsertFirst(aContent);
			
			SetFirstPieceCase();
			if (mFirstPiece == mLastPiece)
			{
				SetLastPiecePonctuation();
			}
		}
		
		override public function InsertLast(aContent:String, aStartPosition:Point, aSkipSound:Boolean = false):void
		{
			if (mLastPiece)
			{
				mLastPiece.Content = mLastPiece.Content.substr(0, mLastPiece.Content.length - 1);
			}
			
			super.InsertLast(aContent, aStartPosition, aSkipSound);
			
			SetLastPiecePonctuation();
			if (mLastPiece == mFirstPiece)
			{
				SetFirstPieceCase();
			}
		}
		
		override public function InsertBefore(aPiece:Piece, aContent:String, aDefaultPosition:Point = null):void
		{
			var first:Boolean = (aPiece == mFirstPiece);
			if (first)
			{
				mFirstPiece.Content = mFirstPiece.Content.toLowerCase();
			}
			
			super.InsertBefore(aPiece, aContent, aDefaultPosition);
			
			if (first)
			{
				SetFirstPieceCase();
			}
		}
		
		override public function InsertAfter(aPiece:Piece, aContent:String, aDefaultPosition:Point = null):void
		{
			var last:Boolean = (aPiece == mLastPiece);
			if (last)
			{
				mLastPiece.Content = mLastPiece.Content.substr(0, mLastPiece.Content.length - 1);
			}
			
			super.InsertAfter(aPiece, aContent, aDefaultPosition);
			
			if (last)
			{
				SetLastPiecePonctuation();
			}
		}
		
		override public function RemoveFirst():void
		{
			super.RemoveFirst();
			
			SetFirstPieceCase();
		}
		
		override public function RemoveLast():void
		{
			super.RemoveLast();
			
			SetLastPiecePonctuation();
		}
		
		private function SetFirstPieceCase():void
		{
			mFirstPiece.Content = mFirstPiece.Content.charAt(0).toUpperCase() + mFirstPiece.Content.substr(1);
		}
		
		private function SetLastPiecePonctuation():void
		{
			mLastPiece.Content += ".";
		}
		
		override protected function OnRemovePiece(aEvent:PieceEvent):void
		{
			switch (aEvent.currentTarget as Piece)
			{
				case mFirstPiece:
					mFirstPiece.Content = mFirstPiece.Content.toLowerCase();
					break;
				case mLastPiece:
					mLastPiece.Content = mLastPiece.Content.substr(0, mLastPiece.Content.length - 1);
					break;
				default:
					break;
			}
			
			super.OnRemovePiece(aEvent);
		}
	}
}