package com.frimastudio.fj_curriculumassociates_edu.ui.piecetray {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class PieceTray extends Sprite
	{
		private static const OFFSET:Number = 10;
		private static const DEADZONE:Number = 50;
		
		private var mEnablePieceDelete:Boolean;
		private var mFirstPiece:Piece;
		private var mLastPiece:Piece;
		private var mAttentionPiece:Piece;
		private var mAttentionCallingTimer:Timer;
		
		public function get Center():Number
		{
			if (mFirstPiece)
			{
				return x + (((mFirstPiece.Position.x - (mFirstPiece.width / 2)) +
					(mLastPiece.Position.x + (mLastPiece.width / 2))) / 2);
			}
			return x;
		}
		
		public function get NextSlotPosition():Number
		{
			if (mLastPiece)
			{
				return x + mLastPiece.Position.x + (mLastPiece.width / 2) + OFFSET;
			}
			return x + OFFSET;
		}
		
		public function PieceTray(aEnablePieceDelete:Boolean, aContentList:Vector.<String> = null)
		{
			super();
			
			mEnablePieceDelete = aEnablePieceDelete;
			
			if (aContentList)
			{
				for (var i:int = 0, endi:int = aContentList.length; i < endi; ++i)
				{
					InsertLast(aContentList[i], (mLastPiece ? mLastPiece.x + (mLastPiece.width / 2) + (2 * OFFSET) : 2 * OFFSET));
				}
			}
			
			mAttentionCallingTimer = new Timer(150, 1);
			mAttentionCallingTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnAttentionCallingTimerComplete);
		}
		
		public function CallAttention():void
		{
			mAttentionCallingTimer.reset();
			
			if (mAttentionPiece)
			{
				mAttentionPiece = mAttentionPiece.NextPiece;
			}
			else
			{
				mAttentionPiece = mFirstPiece;
			}
			
			if (mAttentionPiece)
			{
				mAttentionPiece.CallAttention();
				
				mAttentionCallingTimer.start();
			}
		}
		
		public function Add(aContent:String, aStartPosition:Number):void
		{
			InsertLast(aContent, aStartPosition);
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
			var relativePosition:Point = aPiece.Position.clone();
			relativePosition.x -= x;
			relativePosition.y -= y;
			while (piece)
			{
				if (relativePosition.x <= piece.Position.x && ((piece == mFirstPiece && (!mEnablePieceDelete ||
					relativePosition.x >= piece.Position.x - ((OFFSET + piece.width) / 2) - DEADZONE)) ||
					relativePosition.x >= piece.Position.x - ((OFFSET + piece.width) / 2)) &&
					relativePosition.y >= -((2 * OFFSET) + piece.height) && relativePosition.y <= (2 * OFFSET) + piece.height)
				{
					UpdateTemporaryPositionFrom(piece, OFFSET + aPiece.width);
					break;
				}
				
				if (!piece.NextPiece)
				{
					break;
				}
				
				if (relativePosition.x >= piece.Position.x && ((piece == mLastPiece && (!mEnablePieceDelete ||
					relativePosition.x <= piece.Position.x + ((OFFSET + piece.width) / 2) + (DEADZONE * 2))) ||
					relativePosition.x <= piece.Position.x + ((OFFSET + piece.width) / 2)) &&
					relativePosition.y >= -((2 * OFFSET) + piece.height) && relativePosition.y <= (2 * OFFSET) + piece.height)
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
			
			var relativePosition:Point = aPiece.Position.clone();
			relativePosition.x -= x;
			relativePosition.y -= y;
			if (mFirstPiece)
			{
				var piece:Piece = mFirstPiece;
				while (piece)
				{
					if (relativePosition.x <= piece.Position.x && ((piece == mFirstPiece && (!mEnablePieceDelete ||
						relativePosition.x >= piece.Position.x - ((OFFSET + piece.width) / 2) - DEADZONE)) ||
						relativePosition.x >= piece.Position.x - ((OFFSET + piece.width) / 2)) &&
						relativePosition.y >= -((2 * OFFSET) + piece.height) && relativePosition.y <= (2 * OFFSET) + piece.height)
					{
						InsertBefore(piece, aPiece.Content, relativePosition);
						break;
					}
					
					if (relativePosition.x >= piece.Position.x && ((piece == mLastPiece && (!mEnablePieceDelete ||
						relativePosition.x <= piece.Position.x + ((OFFSET + piece.width) / 2) + (DEADZONE * 2))) ||
						relativePosition.x <= piece.Position.x + ((OFFSET + piece.width) / 2)) &&
						relativePosition.y >= -((2 * OFFSET) + piece.height) && relativePosition.y <= (2 * OFFSET) + piece.height)
					{
						InsertAfter(piece, aPiece.Content, relativePosition);
						break;
					}
					
					piece = piece.NextPiece;
				}
			}
			else
			{
				if (relativePosition.x >= -DEADZONE - (aPiece.width / 2) && relativePosition.x <= DEADZONE + (aPiece.width / 2) &&
					relativePosition.y >= -((2 * OFFSET) + aPiece.height) && relativePosition.y <= (2 * OFFSET) + aPiece.height)
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
		
		private function InsertLast(aContent:String, aStartPosition:Number):void
		{
			mLastPiece = new Piece(mLastPiece, null, aContent, new Point(aStartPosition));
			if (!mFirstPiece)
			{
				mFirstPiece = mLastPiece;
			}
			
			mLastPiece.addEventListener(PieceEvent.REMOVE, OnRemovePiece);
			addChild(mLastPiece);
			mLastPiece.Activate();
			
			UpdatePositionFrom(mLastPiece);
		}
		
		private function InsertBefore(aPiece:Piece, aContent:String, aDefaultPosition:Point = null):void
		{
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Content + " is not in the tray!");
				return;
			}
			
			var piece:Piece = new Piece(aPiece.PreviousPiece, aPiece, aContent, (aDefaultPosition ? aDefaultPosition : new Point()));
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
		
		private function InsertAfter(aPiece:Piece, aContent:String, aDefaultPosition:Point = null):void
		{
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Content + " is not in the tray!");
				return;
			}
			
			var piece:Piece = new Piece(aPiece, aPiece.NextPiece, aContent, (aDefaultPosition ? aDefaultPosition : new Point()));
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
		
		public function RemoveFirst():void
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
			var position:Number = (piece.PreviousPiece ? piece.PreviousPiece.Position.x + (piece.PreviousPiece.width / 2) : 0);
			while (piece)
			{
				position += OFFSET + (piece.width / 2);
				piece.Position = new Point(position, 0);
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
			var position:Number = (piece.PreviousPiece ? piece.PreviousPiece.Position.x + (piece.PreviousPiece.width / 2) : 0);
			position += aTemporaryOffset;
			while (piece)
			{
				position += OFFSET + (piece.width / 2);
				piece.TemporaryPosition = new Point(position, 0);
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
		
		private function OnAttentionCallingTimerComplete(aEvent:TimerEvent):void
		{
			CallAttention();
		}
		
		private function OnRemovePiece(aEvent:PieceEvent):void
		{
			dispatchEvent(new PieceTrayEvent(PieceTrayEvent.PIECE_FREED, aEvent.currentTarget as Piece));
		}
	}
}