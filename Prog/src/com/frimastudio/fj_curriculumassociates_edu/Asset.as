package com.frimastudio.fj_curriculumassociates_edu
{
	public class Asset
	{
		[Embed(source = "../../../../audio/click.mp3")]
		public static var ClickSound:Class;
		[Embed(source = "../../../../audio/slide.mp3")]
		public static var SlideSound:Class;
		
		[Embed(source = "../../../../audio/crescendo.mp3")]
		public static var CrescendoSound:Class;
		[Embed(source = "../../../../audio/validation.mp3")]
		public static var ValidationSound:Class;
		[Embed(source = "../../../../audio/error.mp3")]
		public static var ErrorSound:Class;
		
		[Embed(source = "../../../../audio/instruction.mp3")]
		public static var InstructionSound:Class;
		
		public function Asset()
		{
			throw new Error("Asset is a static class not intended for instantiation!");
		}
	}
}