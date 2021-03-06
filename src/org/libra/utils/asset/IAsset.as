package org.libra.utils.asset {
	import com.greensock.loading.SWFLoader;
	import flash.display.BitmapData;

	public interface IAsset {
		
		function get id():String;
		
		//function set id(value:String):void;
		
		function get url():String;
		
		//function set url(value:String):void;
		
		//function get group():String;
		
		//function set group(value:String):void;
		
		//function load(version:int = 0):void;
		
		function dispose():void;
		
		function get bitmapData():BitmapData;
		
		function get loaded():Boolean;
		
		function doSthAfterLoad(swfLoader:SWFLoader):void;
	}
}
