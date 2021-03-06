package com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class SentenceDecryptingTemplate extends ActivityTemplate
	{
		//private var mWordList:Vector.<String>;
		//private var mAnswer:String;
		//private var mRequest:String;
		private var mRequestVO:Class;
		private var mActivityWordList:Vector.<WordTemplate>;
		private var mLineBreakList:Vector.<int>;
		private var mPhylacteryArrow:Direction;
		
		//public function get WordList():Vector.<String>	{ return mWordList; }
		//public function get Answer():String	{ return mAnswer; }
		public function get Answer():String
		{
			var answer:String = "";
			for (var i:int = 0, endi:int = mActivityWordList.length; i < endi; ++i)
			{
				if (i > 0)
				{
					answer += " ";
				}
				answer += mActivityWordList[i].ChunkList.join("");
			}
			return answer;
		}
		//public function get Request():String	{ return mRequest; }
		public function get RequestVO():Class	{ return mRequestVO; }
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		public function get LineBreakList():Vector.<int>	{ return mLineBreakList; }
		public function get PhylacteryArrow():Direction	{ return mPhylacteryArrow; }
		
		//public function SentenceDecryptingTemplate(aLevel:Level, aWordList:Vector.<String>, aAnswer:String, aRequest:String,
		public function SentenceDecryptingTemplate(aLevel:Level,
			aRequestVO:Class, aActivityWordList:Vector.<WordTemplate>, aLineBreakList:Vector.<int> = null,
			aPhylacteryArrow:Direction = null)
		{
			super(aLevel);
			
			mStepClass = SentenceDecrypting;
			
			//mWordList = aWordList;
			//mAnswer = aAnswer;
			//mRequest = aRequest;
			mRequestVO = aRequestVO;
			mActivityWordList = aActivityWordList;
			mLineBreakList = (aLineBreakList ? aLineBreakList : new Vector.<int>());
			mPhylacteryArrow = (aPhylacteryArrow ? aPhylacteryArrow : Direction.DOWN_LEFT);
		}		
	}
}