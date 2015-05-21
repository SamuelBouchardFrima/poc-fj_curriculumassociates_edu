package com.frimastudio.fj_curriculumassociates_edu.ui.piecetray {
	import com.frimastudio.fj_curriculumassociates_edu.ui.UIButton;
	import com.frimastudio.fj_curriculumassociates_edu.util.MouseUtil;
	import com.greensock.easing.Elastic;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class Piece extends UIButton
	{
		private var mPrevious:Piece;
		private var mNext:Piece;
		private var mPosition:Point;
		private var mTemporaryPosition:Point;
		private var mActive:Boolean;
		private var mMouseDownOrigin:Point;
		private var mDragAutostartTimer:Timer;
		
		public function get PreviousPiece():Piece				{	return mPrevious;	}
		public function set PreviousPiece(aValue:Piece):void	{	mPrevious = aValue;	}
		
		public function get NextPiece():Piece					{	return mNext;		}
		public function set NextPiece(aValue:Piece):void		{	mNext = aValue;		}
		
		public function get Position():Point					{	return mPosition;	}
		public function set Position(aValue:Point):void
		{
			mTemporaryPosition = mPosition = aValue;
			TweenLite.to(this, 0.5, { overwrite:true, ease:Elastic.easeOut, x:mPosition.x, y:mPosition.y });
		}
		
		public function get TemporaryPosition():Point			{	return mTemporaryPosition;	}
		public function set TemporaryPosition(aValue:Point):void
		{
			mTemporaryPosition = aValue;
			TweenLite.to(this, 0.5, { overwrite:true, ease:Elastic.easeOut, x:mTemporaryPosition.x, y:mTemporaryPosition.y });
		}
		
		public function Piece(aPrevious:Piece, aNext:Piece, aContent:String, aPosition:Point = null)
		{
			super(aContent, 0x99EEFF);
			
			mPrevious = aPrevious;
			mNext = aNext;
			mPosition = (aPosition ? aPosition : new Point());
			
			x = mPosition.x;
			y = mPosition.y;
			
			if (mPrevious)
			{
				mPrevious.NextPiece = this;
			}
			if (mNext)
			{
				mNext.PreviousPiece = this;
			}
			
			mDragAutostartTimer = new Timer(500, 1);
			mDragAutostartTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnDragAutostartTimerComplete);
		}
		
		public function Activate():void
		{
			if (mActive)
			{
				throw new Error("Piece " + mContent + " already active!");
				return;
			}
			
			mDragAutostartTimer.reset();
			
			addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
			addEventListener(MouseEvent.CLICK, OnClick);
			mActive = true;
		}
		
		public function Deactivate():void
		{
			if (!mActive)
			{
				throw new Error("Piece " + mContent + " already inactive!");
				return;
			}
			
			mDragAutostartTimer.reset();
			
			removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			removeEventListener(MouseEvent.CLICK, OnClick);
		}
		
		private function OnMouseDown(aEvent:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMoveStage);
			
			mMouseDownOrigin = MouseUtil.PositionRelativeTo(this);
			
			mDragAutostartTimer.reset();
			mDragAutostartTimer.start();
		}
		
		private function OnDragAutostartTimerComplete(aEvent:TimerEvent):void
		{
			dispatchEvent(new PieceEvent(PieceEvent.REMOVE));
		}
		
		private function OnMouseMoveStage(aEvent:MouseEvent):void
		{
			if (mMouseDownOrigin.subtract(MouseUtil.PositionRelativeTo(this)).length >= 15)
			{
				dispatchEvent(new PieceEvent(PieceEvent.REMOVE));
			}
		}
		
		private function OnClick(aEvent:MouseEvent):void
		{
			dispatchEvent(new PieceEvent(PieceEvent.REMOVE, false));
		}
	}
}