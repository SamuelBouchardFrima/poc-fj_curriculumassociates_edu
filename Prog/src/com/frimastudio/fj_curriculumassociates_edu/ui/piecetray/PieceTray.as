package com.frimastudio.fj_curriculumassociates_edu.ui.piecetray
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	public class PieceTray extends Sprite
	{
		private var mTrayExplosion:MovieClip;
		protected static const OFFSET:Number = 10;
		protected static const DEADZONE:Number = 50;
		
		protected var mEnablePieceDelete:Boolean;
		protected var mFirstPiece:Piece;
		protected var mLastPiece:Piece;
		//protected var mAttentionPiece:Piece;
		protected var mAttentionCallingTimer:Timer;
		
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
		
		public function get MoreThanOne():Boolean
		{
			return mFirstPiece != mLastPiece;
		}
		
		public function get Empty():Boolean
		{
			return !mFirstPiece;
		}
		
		public function set Color(aValue:int):void
		{
			var piece:Piece = mFirstPiece;
			while (piece)
			{
				piece.BoxColor = aValue;
				piece = piece.NextPiece;
			}
		}
		
		public function set ContentColor(aValue:int):void
		{
			var piece:Piece = mFirstPiece;
			while (piece)
			{
				piece.Content = new BoxLabel(piece.Label, 60, aValue);
				piece = piece.NextPiece;
			}
		}
		
		public function PieceTray(aEnablePieceDelete:Boolean, aContentList:Vector.<String> = null)
		{
			super();
			
			mEnablePieceDelete = aEnablePieceDelete;
			
			if (aContentList)
			{
				for (var i:int = 0, endi:int = aContentList.length; i < endi; ++i)
				{
					InsertLast(aContentList[i], new Point((mLastPiece ? mLastPiece.x + (mLastPiece.width / 2) + (2 * OFFSET) : 2 * OFFSET)), true);
				}
			}
			
			mAttentionCallingTimer = new Timer(150, 1);
			mAttentionCallingTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnAttentionCallingTimerComplete);
		}
		
		public function Dispose():void
		{
			Clear();
		}
		
		public function CallAttention(aSelection:String = ""):void
		{
			mAttentionCallingTimer.reset();
			
			var list:Vector.<Piece> = new Vector.<Piece>();
			var piece:Piece = mFirstPiece;
			while (piece)
			{
				if (!aSelection.length || aSelection.indexOf(piece.Label) > -1)
				{
					list.push(piece);
				}
				piece = piece.NextPiece;
			}
			
			if (list.length)
			{
				(Random.FromList(list) as Piece).CallAttention();
			}
		}
		
		public function BounceInSequence():Number
		{
			var piece:Piece = mFirstPiece;
			var i:int = 0;
			while (piece)
			{
				TweenLite.to(piece, 0.15, { ease:Strong.easeOut, delay:(i * 0.05), onComplete:OnTweenFusePiece,
					onCompleteParams:[piece, OnTweenBouncePiece], x:(piece.x - (i * (OFFSET + 12))), y:(piece.height * 0.15),
					scaleX:1.15, scaleY:0.7 });
				
				++i;
				piece = piece.NextPiece;
			}
			return (0.7 + ((i - 1) * 0.05));
		}
		
		public function FizzleAndExplode():Number
		{
			var piece:Piece = mFirstPiece;
			var i:int = 0;
			while (piece)
			{
				TweenLite.to(piece, 0.15, { ease:Strong.easeOut, delay:(i * 0.05), onComplete:OnTweenFusePiece,
					onCompleteParams:[piece, (i % 2 ? OnTweenFizzleUpPiece : OnTweenFizzleDownPiece)],
					x:(piece.x - (i * (OFFSET + 12))) });
				
				++i;
				piece = piece.NextPiece;
			}
			
			var explodeTimer:Timer = new Timer(700, 1);
			explodeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnExplodeTimerComplete);
			explodeTimer.start();
			
			return 2;
		}
		
		public function Add(aContent:String, aStartPosition:Number):void
		{
			InsertLast(aContent, new Point(aStartPosition));
		}
		
		public function Clear(aContentList:Vector.<String> = null):void
		{
			if (mTrayExplosion)
			{
				removeChild(mTrayExplosion);
				mTrayExplosion = null;
			}
			
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
				piece.DisableMouseOver();
				piece.Dispose();
				removeChild(piece);
				piece = piece.NextPiece;
			}
			mFirstPiece = null;
			mLastPiece = null;
			
			if (aContentList)
			{
				for (var i:int = 0, endi:int = aContentList.length; i < endi; ++i)
				{
					InsertLast(aContentList[i], new Point((mLastPiece ? mLastPiece.x + (mLastPiece.width / 2) + (2 * OFFSET) : 2 * OFFSET)), true);
				}
			}
		}
		
		public function AssembleWord():String
		{
			var word:String = "";
			var piece:Piece = mFirstPiece;
			while (piece)
			{
				word += piece.Label;
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
				sentence.push(piece.Label);
				piece = piece.NextPiece;
			}
			//if (sentence.length)
			//{
				//sentence[0] = sentence[0].charAt(0).toUpperCase() + sentence[0].substring(1);
				//sentence[sentence.length - 1] += ".";
			//}
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
				throw new Error("Piece " + aPiece.Label + " already inserted! No need to make place.");
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
		
		public function FreePlace():void
		{
			UpdatePositionFrom(mFirstPiece);
		}
		
		public function Insert(aPiece:Piece, aPreviousPosition:Piece = null):void
		{
			if (Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Label + " already inserted!");
				return;
			}
			
			var newPosition:Boolean;
			
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
						InsertBefore(piece, aPiece.Label, relativePosition);
						newPosition = true;
						break;
					}
					
					if (relativePosition.x >= piece.Position.x && ((piece == mLastPiece && (!mEnablePieceDelete ||
						relativePosition.x <= piece.Position.x + ((OFFSET + piece.width) / 2) + (DEADZONE * 2))) ||
						relativePosition.x <= piece.Position.x + ((OFFSET + piece.width) / 2)) &&
						relativePosition.y >= -((2 * OFFSET) + piece.height) && relativePosition.y <= (2 * OFFSET) + piece.height)
					{
						InsertAfter(piece, aPiece.Label, relativePosition);
						newPosition = true;
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
					InsertFirst(aPiece.Label);
					newPosition = true;
				}
			}
			
			if (!newPosition && !mEnablePieceDelete)
			{
				if (Contain(aPreviousPosition))
				{
					InsertBefore(aPreviousPosition, aPiece.Label, relativePosition);
				}
				else
				{
					InsertLast(aPiece.Label, relativePosition);
				}
			}
			
			dispatchEvent(new PieceTrayEvent(PieceTrayEvent.PIECE_CAPTURED, aPiece));
		}
		
		public function InsertFirst(aContent:String):void
		{
			mFirstPiece = new Piece(null, mFirstPiece, aContent);
			mFirstPiece.EnableMouseOver();
			if (!mLastPiece)
			{
				mLastPiece = mFirstPiece;
			}
			
			mFirstPiece.addEventListener(PieceEvent.REMOVE, OnRemovePiece);
			addChild(mFirstPiece);
			mFirstPiece.Activate();
			
			UpdatePositionFrom(mFirstPiece);
			
			(new Asset.ClickSound() as Sound).play();
		}
		
		public function InsertLast(aContent:String, aStartPosition:Point, aSkipSound:Boolean = false):void
		{
			mLastPiece = new Piece(mLastPiece, null, aContent, aStartPosition);
			mLastPiece.EnableMouseOver();
			if (!mFirstPiece)
			{
				mFirstPiece = mLastPiece;
			}
			
			mLastPiece.addEventListener(PieceEvent.REMOVE, OnRemovePiece);
			addChild(mLastPiece);
			mLastPiece.Activate();
			
			UpdatePositionFrom(mLastPiece);
			
			if (!aSkipSound)
			{
				(new Asset.ClickSound() as Sound).play();
			}
		}
		
		public function InsertBefore(aPiece:Piece, aContent:String, aDefaultPosition:Point = null):void
		{
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Label + " is not in the tray!");
				return;
			}
			
			var piece:Piece = new Piece(aPiece.PreviousPiece, aPiece, aContent, (aDefaultPosition ? aDefaultPosition : new Point()));
			piece.EnableMouseOver();
			aPiece.PreviousPiece = piece;
			if (mFirstPiece == aPiece)
			{
				mFirstPiece = piece;
			}
			
			piece.addEventListener(PieceEvent.REMOVE, OnRemovePiece);
			addChild(piece);
			piece.Activate();
			
			UpdatePositionFrom(piece);
			
			(new Asset.ClickSound() as Sound).play();
		}
		
		public function InsertAfter(aPiece:Piece, aContent:String, aDefaultPosition:Point = null):void
		{
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Label + " is not in the tray!");
				return;
			}
			
			var piece:Piece = new Piece(aPiece, aPiece.NextPiece, aContent, (aDefaultPosition ? aDefaultPosition : new Point()));
			piece.EnableMouseOver();
			aPiece.NextPiece = piece;
			if (mLastPiece == aPiece)
			{
				mLastPiece = piece;
			}
			
			piece.addEventListener(PieceEvent.REMOVE, OnRemovePiece);
			addChild(piece);
			piece.Activate();
			
			UpdatePositionFrom(piece);
			
			(new Asset.ClickSound() as Sound).play();
		}
		
		public function Remove(aPiece:Piece):void
		{
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Label + " is not in the tray!");
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
			aPiece.DisableMouseOver();
			aPiece.Dispose();
			removeChild(aPiece);
			
			aPiece.PreviousPiece.NextPiece = aPiece.NextPiece;
			aPiece.NextPiece.PreviousPiece = aPiece.PreviousPiece;
			
			UpdatePositionFrom(aPiece.NextPiece);
			
			aPiece.PreviousPiece = null;
			aPiece.NextPiece = null;
			
			(new Asset.SlideSound() as Sound).play();
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
			piece.DisableMouseOver();
			piece.Dispose();
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
			
			(new Asset.SlideSound() as Sound).play();
		}
		
		public function RemoveLast():Piece
		{
			if (!mLastPiece)
			{
				return null;
			}
			
			var piece:Piece = mLastPiece;
			
			piece.removeEventListener(PieceEvent.REMOVE, OnRemovePiece);
			piece.Deactivate();
			piece.DisableMouseOver();
			piece.Dispose();
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
			
			(new Asset.SlideSound() as Sound).play();
			
			return piece;
		}
		
		protected function UpdatePositionFrom(aPiece:Piece):void
		{
			if (!aPiece)
			{
				return;
			}
			
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Label + " is not in the tray!");
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
		
		protected function UpdateTemporaryPositionFrom(aPiece:Piece, aTemporaryOffset:Number):void
		{
			if (!aPiece)
			{
				return;
			}
			
			if (!Contain(aPiece))
			{
				throw new Error("Piece " + aPiece.Label + " is not in the tray!");
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
		
		protected function Contain(aPiece:Piece):Boolean
		{
			if (!aPiece)
			{
				return false;
			}
			
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
		
		protected function OnAttentionCallingTimerComplete(aEvent:TimerEvent):void
		{
			CallAttention();
		}
		
		private function OnTweenFusePiece(aPiece:Piece, aNextTweenHandler:Function):void
		{
			switch (aNextTweenHandler)
			{
				case OnTweenBouncePiece:
					TweenLite.to(aPiece, 0.25, { ease:Strong.easeOut, onComplete:OnTweenBouncePiece,
						onCompleteParams:[aPiece], y:-50, scaleX:0.85, scaleY:1.15 });
					break;
				case OnTweenFizzleUpPiece:
					TweenLite.to(aPiece, 0.05, { ease:Strong.easeOut, onComplete:OnTweenFizzleUpPiece,
						onCompleteParams:[aPiece], y:-2, scaleX:1, scaleY:1 });
					break;
				case OnTweenFizzleDownPiece:
					TweenLite.to(aPiece, 0.05, { ease:Strong.easeOut, onComplete:OnTweenFizzleDownPiece,
						onCompleteParams:[aPiece], y:2, scaleX:1, scaleY:1 });
					break;
				default:
					break;
			}
		}
		
		private function OnTweenBouncePiece(aPiece:Piece):void
		{
			TweenLite.to(aPiece, 0.3, { ease:Bounce.easeOut, y:0, scaleX:1, scaleY:1 });
		}
		
		private function OnTweenFizzleUpPiece(aPiece:Piece):void
		{
			TweenLite.to(aPiece, 0.05, { ease:Strong.easeOut, onComplete:OnTweenFizzleDownPiece,
				onCompleteParams:[aPiece], y:2, scaleX:1, scaleY:1 });
		}
		
		private function OnTweenFizzleDownPiece(aPiece:Piece):void
		{
			TweenLite.to(aPiece, 0.05, { ease:Strong.easeOut, onComplete:OnTweenFizzleUpPiece,
				onCompleteParams:[aPiece], y:-2, scaleX:1, scaleY:1 });
		}
		
		private function OnExplodeTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnExplodeTimerComplete);
			
			var piece:Piece = mFirstPiece;
			var i:int = 0;
			var whiteBox:CurvedBox;
			while (piece)
			{
				TweenLite.killTweensOf(piece);
				TweenLite.to(piece, 0.05, { ease:Strong.easeOut, y:0 });
				
				whiteBox = new CurvedBox(piece.Size, 0xFFFFFF);
				whiteBox.x = piece.x;
				whiteBox.alpha = 0;
				addChild(whiteBox);
				TweenLite.to(whiteBox, 0.1, { ease:Strong.easeOut, delay:((i * 0.07) + 0.05), onComplete:OnTweenWhitenPiece,
					onCompleteParams:[piece, whiteBox], alpha:1 });
				
				++i;
				piece = piece.NextPiece;
			}
			
			TweenLite.to(this, 0.3, { onComplete:OnTweenExplodeTray });
		}
		
		private function OnTweenWhitenPiece(aPiece:Piece, aWhiteBox:CurvedBox):void
		{
			aPiece.alpha = 0;
			
			TweenLite.to(aWhiteBox, 0.15, { ease:Strong.easeIn, onComplete:OnTweenExplodePiece,
				onCompleteParams:[aWhiteBox], scaleX:1.2, scaleY:1.2 });
		}
		
		private function OnTweenExplodePiece(aWhiteBox:CurvedBox):void
		{
			var explosion:MovieClip = new Asset.PieceExplosionClip() as MovieClip;
			explosion.x = aWhiteBox.x;
			explosion.y = aWhiteBox.y;
			addChild(explosion);
			if (mTrayExplosion)
			{
				addChild(mTrayExplosion);
			}
			
			TweenLite.to(aWhiteBox, 0.3, { ease:Strong.easeOut, delay:0.2, onComplete:OnTweenHideExplosion,
				onCompleteParams:[aWhiteBox, explosion], scaleX:2, scaleY:2, alpha:0 });
			
			(new Asset.PieceExplosionSound() as Sound).play();
		}
		
		private function OnTweenHideExplosion(aWhiteBox:CurvedBox, aExplosion:MovieClip):void
		{
			removeChild(aWhiteBox);
			removeChild(aExplosion);
		}
		
		private function OnTweenExplodeTray():void
		{
			mTrayExplosion = new Asset.TrayExplosionClip() as MovieClip;
			addChild(mTrayExplosion);
			
			(new Asset.TrayExplosionSound() as Sound).play();
		}
		
		protected function OnRemovePiece(aEvent:PieceEvent):void
		{
			dispatchEvent(new PieceTrayEvent(PieceTrayEvent.PIECE_FREED, aEvent.currentTarget as Piece, aEvent.Dragged));
		}
	}
}