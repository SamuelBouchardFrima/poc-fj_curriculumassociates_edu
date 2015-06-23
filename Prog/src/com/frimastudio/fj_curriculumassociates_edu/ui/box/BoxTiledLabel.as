package com.frimastudio.fj_curriculumassociates_edu.ui.box
{
	public class BoxTiledLabel extends BoxContent
	{
		private var mLabel:String;
		private var mSize:Number;
		private var mTileColorList:Vector.<int>;
		
		public function get Label():String	{ return mLabel; }
		public function set Label(aValue:String):void	{ mLabel = aValue; }
		
		public function get Size():Number	{ return mSize; }
		public function set Size(aValue:Number):void { mSize = aValue; }
		
		public function get TileColorList():Vector.<int>	{ return mTileColorList; }
		public function set TileColorList(aValue:Vector.<int>):void { mTileColorList = aValue; }
		
		public function BoxTiledLabel(aLabel:String, aSize:Number = 0, aColor:int = -1, aTileColorList:Vector.<int> = null)
		{
			super(aColor);
			
			mLabel = aLabel;
			mSize = aSize;
			mTileColorList = aTileColorList;
		}
	}
}