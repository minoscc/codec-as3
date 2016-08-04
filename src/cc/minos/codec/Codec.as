/**
 * ...
 * Author: SiuzukZan <minoscc@gmail.com>
 * Date: 14/12/24 10:58
 */
package cc.minos.codec {

	import flash.utils.ByteArray;
	
	import cc.minos.codec.flv.Frame;

	public class Codec extends Object {

		//封装类型
		protected var _name:String = ':)'
		//拓展
		protected var _extensions:String;
		//格式
		protected var _mimeType:String;
		//源數據
		protected var _rawData:ByteArray = new ByteArray;

		//幀列表，包括視頻音頻
		protected var _frames:Vector.<Frame> = new Vector.<Frame>();
		//關鍵幀列表
		protected var _keyframes:Array;

		//視頻
		protected var _hasVideo:Boolean = false; //是否有視頻數據
		protected var _videoConfig:ByteArray = null; //sps & pps  解析數據
		protected var _videoCodec:uint; //編碼類型
		protected var _videoWidth:Number = 0.0;  //寬
		protected var _videoHeight:Number = 0.0; //高
		protected var _videoRate:Number; //比特率

		//幀頻fps
		protected var _frameRate:Number = 0.0;

		//音頻
		protected var _hasAudio:Boolean = false; //是否有音頻
		protected var _audioConfig:ByteArray = null; //音頻解析數據
		protected var _audioCodec:uint; //編碼類型
		protected var _audioType:uint = 10; //音頻類型
		protected var _audioRate:Number = 44100; //赫茲
		protected var _audioSize:Number = 16; //質量
		protected var _audioChannels:uint = 2; //聲道
		protected var _audioProperties:uint = 0; //標籤

		//時間
		protected var _duration:Number = 0.0;

		public function Codec()
		{
		}

		/* byte handlers */

		protected function byte_r8(s:*):int
		{
			if (s.position < s.length)
				return s.readUnsignedByte();
			return 0;
		}

		protected function byte_rb16(s:*):uint
		{
			var val:uint;
			val = byte_r8(s) << 8;
			val |= byte_r8(s);
			return val;
		}

		protected function byte_rb24(s:*):uint
		{
			var val:uint;
			val = byte_rb16(s) << 8;
			val |= byte_r8(s);
			return val;
		}

		protected function byte_rb32(s:*):uint
		{
			var val:uint;
			val = byte_rb16(s) << 16;
			val |= byte_rb16(s);
			return val;
		}

		protected function byte_w8(s:*, b:int):void
		{
			if (b >= -128 && b <= 255)
				s.writeByte(b);
		}

		protected function byte_wb16(s:*, b:uint):void
		{
			byte_w8(s, b >> 8)
			byte_w8(s, b & 0xff);
		}

		protected function byte_wb24(s:*, b:uint):void
		{
			byte_wb16(s, b >> 8);
			byte_w8(s, b & 0xff);
		}

		protected function byte_wb32(s:*, b:uint):void
		{
			byte_w8(s, b >> 24);
			byte_w8(s, b >> 16 & 0xff);
			byte_w8(s, b >> 8 & 0xff);
			byte_w8(s, b & 0xff);
		}

		/* byte handlers end */

		public function decode(input:ByteArray):Codec
		{
			return null;
		}

		public function encode(input:Codec):ByteArray
		{
			return null;
		}

		public function getDataByFrame(frame:Frame):ByteArray
		{
			var b:ByteArray = new ByteArray();
			if(_rawData.length >= frame.offset + frame.size)
			{
				b.writeBytes(_rawData, frame.offset, frame.size);
//				trace(this,_rawData.bytesAvailable, _rawData.position, _rawData.length);
				return b;
			}
//			trace(this,_rawData.bytesAvailable, _rawData.position);
			return null;
		}

		public function export():ByteArray
		{
			return _rawData;
		}

		public function exportVideo():ByteArray
		{
			return null;
		}

		public function exportAudio():ByteArray
		{
			return null;
		}

		public function get name():String
		{
			return _name;
		}

		public function get frames():Vector.<Frame>
		{
			return _frames;
		}

		public function get keyframes():Array
		{
			return _keyframes;
		}

		public function get duration():Number
		{
			return _duration;
		}

		public function get frameRate():Number
		{
			return _frameRate;
		}

		public function get hasVideo():Boolean
		{
			return _hasVideo;
		}

		public function get hasAudio():Boolean
		{
			return _hasAudio;
		}

		public function get videoConfig():ByteArray
		{
			return _videoConfig;
		}

		public function get videoCodec():uint
		{
			return _videoCodec;
		}

		public function get videoWidth():Number
		{
			return _videoWidth;
		}

		public function get videoHeight():Number
		{
			return _videoHeight;
		}

		public function get videoRate():Number
		{
			return _videoRate;
		}

		public function get audioConfig():ByteArray
		{
			return _audioConfig;
		}

		public function get audioCodec():uint
		{
			return _audioCodec;
		}

		public function get audioType():uint
		{
			return _audioType;
		}

		public function get audioRate():Number
		{
			return _audioRate;
		}

		public function get audioSize():Number
		{
			return _audioSize;
		}

		public function get audioChannels():uint
		{
			return _audioChannels;
		}

	}
}
