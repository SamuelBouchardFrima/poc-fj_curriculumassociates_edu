package com.frimastudio.fj_curriculumassociates_edu.ui.piecetray {
	import flash.display.Sprite;
	
	public class PieceTray extends Sprite
	{
		private static const OFFSET:Number = 10;
		private static const DEADZONE:Number = 50;
		
		private var mEnablePieceDelete:Boolean;
		private var mFirstPiece:Piece;
		private var mLastPiece:Piece;
		
		public function get Center():Number
		{
			if (mFirstPiece)
			{
				return x + (((mFirstPiece.x - (mFirstPiece.width / 2)) + (mLastPiece.x + (mLastPiece.width / 2))) / 2);
			}
			return x;
		}
		
		public function PieceTray(aEnablePieceDelete:Boolean, aContentList:Vector.<String> = null)
		{
			super();
			
			mEnablePieceDelete = aEnablePieceDelete;
			
			if (aContentList)
			{
				for (var i:int = 0, endi:int = aContentList.length; i < endi; ++i)
				{
					InsertLast(aContentList[i]);
				}
			}
		}
		
		public function Add(aContent:String):void
		{
			InsertLast(aContent);
		}
		
		public function Clear():void
		{
			var piece:Piece = mFirstPiece;
			while (piece)
			{
				piece.Deactivate();
				if (piece.PreviousPiece)
				{
					piece.removeEventListener(PieceEvent.REMOVE, OnRemovePiece);
					piece.PreviousPiece.NextPiece = null;
					piece.PreviousPiece = null;
				}
				removeChild(piece);
				piece = piece.NextPiece;
			}
			mFirstPiece = null;
			mLastPiece = null;
		}
		
		public function AssembleWord():String
		{
			var word:String = "";
			var piece:Piece = mFirstPiece;
			while (piece)
			{
				word += piece.Content;
				piece = piece.NextPiece;
			}
			return word;
		}
		
		public function AssembleSentence():String
		{
			var sentence:Vector.<String> = new Vector.<String>();
			var piece:Piece = mFirstPiece;
			while (piece)
			{
				sentence.push(piece.Content);
				piece = piece.NextPiece;
			}
			return sentence.join(" ");
		}
		
		public function MakePlace(aPiece:Piece):void
		{
			if (!mFirstPiece)
			{
				return;
			}
			
			if (Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Content + " already inserted! No need to make place.");
				return;
			}
			
			UpdatePositionFrom(mFirstPiece);
			
			var piece:Piece = mFirstPiece;
			var relativePosition:Number = aPiece.Position - x;
			while (piece)
			{
				if (relativePosition <= piece.Position && ((piece == mFirstPiece && (!mEnablePieceDelete ||
					relativePosition >= piece.Position - ((OFFSET + piece.width) / 2) - DEADZONE)) ||
					relativePosition >= piece.Position - ((OFFSET + piece.width) / 2)))
				{
					UpdateTemporaryPositionFrom(piece, OFFSET + aPiece.width);
					break;
				}
				
				if (!piece.NextPiece)
				{
					break;
				}
				
				if (relativePosition >= piece.Position && ((piece == mLastPiece && (!mEnablePieceDelete ||
					relativePosition <= piece.Position + ((OFFSET + piece.width) / 2) + (DEADZONE * 2))) ||
					relativePosition <= piece.Position + ((OFFSET + piece.width) / 2)))
				{
					UpdateTemporaryPositionFrom(piece.NextPiece, aPiece.width + OFFSET);
					break;
				}
				
				piece = piece.NextPiece;
			}
		}
		
		public function Insert(aPiece:Piece):void
		{
			if (Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Content + " already inserted!");
				return;
			}
			
			var relativePosition:Number = aPiece.Position - x;
			if (mFirstPiece)
			{
				var piece:Piece = mFirstPiece;
				while (piece)
				{
					if (relativePosition <= piece.Position && ((piece == mFirstPiece && (!mEnablePieceDelete ||
						relativePosition >= piece.Position - ((OFFSET + piece.width) / 2) - DEADZONE)) ||
						relativePosition >= piece.Position - ((OFFSET + piece.width) / 2)))
					{
						InsertBefore(piece, aPiece.Content, aPiece.Position - x);
						break;
					}
					
					if (relativePosition >= piece.Position && ((piece == mLastPiece && (!mEnablePieceDelete ||
						relativePosition <= piece.Position + ((OFFSET + piece.width) / 2) + (DEADZONE * 2))) ||
						relativePosition <= piece.Position + ((OFFSET + piece.width) / 2)))
					{
						InsertAfter(piece, aPiece.Content, aPiece.Position - x);
						break;
					}
					
					piece = piece.NextPiece;
				}
			}
			else
			{
				if (relativePosition >= -DEADZONE - (aPiece.width / 2) && relativePosition <= DEADZONE + (aPiece.width / 2))
				{
					InsertFirst(aPiece.Content);
				}
			}
			
			dispatchEvent(new PieceTrayEvent(PieceTrayEvent.PIECE_CAPTURED, aPiece));
		}
		
		private function InsertFirst(aContent:String):void
		{
			mFirstPiece = new Piece(null, mFirstPiece, aContent);
			if (!mLastPiece)
			{
				mLastPiece = mFirstPiece;
			}
			
			mFirstPiece.addEventListener(PieceEvent.REMOVE, OnRemovePiece);
			addChild(mFirstPiece);
			mFirstPiece.Activate();
			
			UpdatePositionFrom(mFirstPiece);
		}
		
		private function InsertLast(aContent:String):void
		{
			mLastPiece = new Piece(mLastPiece, null, aContent);
			if (!mFirstPiece)
			{
				mFirstPiece = mLastPiece;
			}
			
			mLastPiece.addEventListener(PieceEvent.REMOVE, OnRemovePiece);
			addChild(mLastPiece);
			mLastPiece.Activate();
			
			UpdatePositionFrom(mLastPiece);
		}
		
		private function InsertBefore(aPiece:Piece, aContent:String, aDefaultPosition:Number = 0):void
		{
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Content + " is not in the tray!");
				return;
			}
			
			var piece:Piece = new Piece(aPiece.PreviousPiece, aPiece, aContent, aDefaultPosition);
			aPiece.PreviousPiece = piece;
			if (mFirstPiece == aPiece)
			{
				mFirstPiece = piece;
			}
			
			piece.addEventListener(PieceEvent.REMOVE, OnRemovePiece);
			addChild(piece);
			piece.Activate();
			
			UpdatePositionFrom(piece);
		}
		
		private function InsertAfter(aPiece:Piece, aContent:String, aDefaultPosition:Number = 0):void
		{
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Content + " is not in the tray!");
				return;
			}
			
			var piece:Piece = new Piece(aPiece, aPiece.NextPiece, aContent, aDefaultPosition);
			aPiece.NextPiece = piece;
			if (mLastPiece == aPiece)
			{
				mLastPiece = piece;
			}
			
			piece.addEventListener(PieceEvent.REMOVE, OnRemovePiece);
			addChild(piece);
			piece.Activate();
			
			UpdatePositionFrom(piece);
		}
		
		public function Remove(aPiece:Piece):void
		{
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Content + " is not in the tray!");
				return;
			}
			
			switch (aPiece)
			{
				case mFirstPiece:
					RemoveFirst();
					return;
				case mLastPiece:
					RemoveLast();
					return;
				default:
					break;
			}
			
			aPiece.removeEventListener(PieceEvent.REMOVE, OnRemovePiece);
			aPiece.Deactivate();
			removeChild(aPiece);
			
			aPiece.PreviousPiece.NextPiece = aPiece.NextPiece;
			aPiece.NextPiece.PreviousPiece = aPiece.PreviousPiece;
			
			UpdatePositionFrom(aPiece.NextPiece);
			
			aPiece.PreviousPiece = null;
			aPiece.NextPiece = null;
		}
		
		private function RemoveFirst():void
		{
			if (!mFirstPiece)
			{
				return;
			}
			
			var piece:Piece = mFirstPiece;
			
			piece.removeEventListener(PieceEvent.REMOVE, OnRemovePiece);
			piece.Deactivate();
			removeChild(piece);
			
			if (piece == mLastPiece)
			{
				mFirstPiece = null;
				mLastPiece = null;
			}
			else
			{
				mFirstPiece = piece.NextPiece;
				mFirstPiece.PreviousPiece = null;
				
				UpdatePositionFrom(mFirstPiece);
			}
		}
		
		private function RemoveLast():void
		{
			if (!mLastPiece)
			{
				return;
			}
			
			var piece:Piece = mLastPiece;
			
			piece.removeEventListener(PieceEvent.REMOVE, OnRemovePiece);
			piece.Deactivate();
			removeChild(piece);
			
			if (piece == mFirstPiece)
			{
				mLastPiece = null;
				mFirstPiece = null;
			}
			else
			{
				mLastPiece = piece.PreviousPiece;
				mLastPiece.NextPiece = null;
			}
		}
		
		private function UpdatePositionFrom(aPiece:Piece):void
		{
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Content + " is not in the tray!");
				return;
			}
			
			var piece:Piece = aPiece;
			var position:Number = (piece.PreviousPiece ? piece.PreviousPiece.Position + (piece.PreviousPiece.width / 2) : 0);
			while (piece)
			{
				position += OFFSET + (piece.width / 2);
				piece.Position = position;
				position += piece.width / 2;
				piece = piece.NextPiece;
			}
		}
		
		private function UpdateTemporaryPositionFrom(aPiece:Piece, aTemporaryOffset:Number):void
		{
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Content + " is not in the tray!");
				return;
			}
			
			var piece:Piece = aPiece;
			var position:Number = (piece.PreviousPiece ? piece.PreviousPiece.Position + (piece.PreviousPiece.width / 2) : 0);
			position += aTemporaryOffset;
			while (piece)
			{
				position += OFFSET + (piece.width / 2);
				piece.TemporaryPosition = position;
				position += piece.width / 2;
				piece = piece.NextPiece;
			}
		}
		
		private function Contain(aPiece:Piece):Boolean
		{
			var piece:Piece = mFirstPiece;
			while (piece)
			{
				if (piece == aPiece)
				{
					return true;
				}
				
				piece = piece.NextPiece;
			}
			return false;
		}
		
		private function OnRemovePiece(aEvent:PieceEvent):void
		{
			dispatchEvent(new PieceTrayEvent(PieceTrayEvent.PIECE_FREED, aEvent.currentTarget as Piece));
		}
	}
}