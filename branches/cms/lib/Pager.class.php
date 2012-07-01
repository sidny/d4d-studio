<?php
/**
  * 实现翻页功能的类 
  * 输出页的列表
  * 创建类后由genYuan()输出
*/

class Pager{
	const PAGE_PRE = '上一页';
	const PAGE_NEXT = '下一页';

    private $_rowCount = 0;//总条目数
    private $_pageNo = 1;//当前页码
    private $_pageSize = 20;//每页条目数
    private $_pageCount = 0;
    private $_offset = 0;//当前条目
    private $_pageString = 'p';//页码变量

    private $_script = null; //指的就是URL前半部分的
    private $_valueArray = array();
    
    public function __construct($options=array()) {   
		if(!isset($options['script_uri']))
			$this->defaultQuery();
		else
			$this->defaultQuery($options['script_uri']);
        $this->_valueArray = isset($options['valueArray']) ? $options['valueArray'] : $this->_valueArray;
        $this->_pageString = isset($options['pageString']) ? $options['pageString'] : $this->_pageString;
        $this->_pageSize = isset($options['pageSize']) ? intval($options['pageSize']) : $this->_pageSize;
        $this->_rowCount = isset($options['rowCount']) ? intval($options['rowCount']) : $this->_rowCount;

        $this->_pageCount = ceil($this->_rowCount/$this->_pageSize);
        $this->_pageCount = ($this->_pageCount<=0)?1:$this->_pageCount;
		$i = isset($_REQUEST[$this->_pageString]) ? intval($_REQUEST[$this->_pageString]) : 1;
        $this->_pageNo = isset($options['pageNo']) ?  intval($options['pageNo']) : $i;
		$this->_pageNo = $this->_pageNo<=0 ? 1 : $this->_pageNo;
		$this->_pageNo = $this->_pageNo > $this->_pageCount ? $this->_pageCount : $this->_pageNo;
        $this->_offset = ( $this->_pageNo - 1 ) * $this->_pageSize;
    }   

    private function genURL( $url="/", $param, $value ){
        if( false === strpos($url,'?')) return $url.'?'.urlEncode($param).'='.urlEncode($value);
        else return $url.'&'.urlEncode($param).'='.urlEncode($value);
    }

	/**
	  * 内部函数初始化
	  * $this->_valueArray和$this->_script 2个变量
	  */
    private function defaultQuery($script_uri=null) {
		if(empty($script_uri))
			$script_uri = $_SERVER['REQUEST_URI'];
        $q_pos = strpos($script_uri,'?');
        if ( $q_pos > 0 )
        {
            $qstring = substr($script_uri, $q_pos+1);
			$qstring = str_replace('#38;', '', $qstring);
            parse_str($qstring, $valueArray);
            $script = substr($script_uri,0,$q_pos);
        }
        else
        {
            $script = $script_uri;
            $valueArray = array();
        }
        $this->_valueArray = empty($valueArray)
            ? array()
            : $valueArray;
        $this->_script = $script;
    }

    private function genHref($url, $value='')
    {
        return $this->genURL($url, $this->_pageString, $value);
    }

    public function paginate($url=null){
        $from = $this->_pageSize*($this->_pageNo-1)+1;
        $from = ($from>$this->_rowCount) ? $this->_rowCount : $from;
        $to = $this->_pageNo * $this->_pageSize;
        $to = ($to>$this->_rowCount) ? $this->_rowCount : $to;
        $size = $this->_pageSize;
        $no = $this->_pageNo;
        $max = $this->_pageCount;
        $total = $this->_rowCount;
        $html = empty($url) ? '' : $this->genHref($url);

        return array(
            'from' => $from,
            'to' => $to,
            'size' => $size,
            'no' => $no,
            'max' => $max,
            'total' => $total,
            'html' => $html,
        );
    }

    public function genLink($str, $val, $ignore='') {
        $url = $this->_script;
		//$url = rtrim($url,'/') . '/';
        foreach($this->_valueArray as $key=>$value) {
            if ( $key != $str && $key!=$ignore) {
                $url = $this->genURL($url,$key,$value);
            }
        }
        return $this->genURL($url, $str, $val);
	}

    public function genYuan()
    {
        $url = $this->_script;
		//$url = rtrim($url,'/') . '/';
        foreach($this->_valueArray as $key=>$value) {
            if ( $key != $this->_pageString ) {
                $url = $this->genURL($url,$key,$value);
            }
        }
        //Pager Rule by lecause@apsire-tech.com 
        //convert by haohang@aspire-tech.com 2008-07-28
        if ( $this->_pageNo < 7 ) {//前6页
            if ( $this->_pageNo > 4 ) {
                $range = range(1, ($this->_pageNo+2));
            } else {
                $range = range(1, 6);
            }
			$range = array_merge(
				$range,
				range($this->_pageCount-1, $this->_pageCount)
			);
        } else if ( ($this->_pageCount-$this->_pageNo) < 6 ) {//后6页
            if ( ($this->_pageCount-$this->_pageNo) > 3 ) {
				$range = array_merge(
					array(1, 2),
					range($this->_pageNo-2, $this->_pageCount)
				);
            } else {
				$range = array_merge(
					array(1, 2),
					range($this->_pageCount-5, $this->_pageCount)
				);
            }
        } else {
			$range = array_merge(
				array(1,2),
				range($this->_pageNo-2, $this->_pageNo+2),
				array($this->_pageCount-1, $this->_pageCount)
			);
        }

        //Add by seek@jiwai.com 2008-07-14
        if ( $this->_pageCount <= 10 )
            $range = range(1, $this->_pageCount);

        $range = array_unique($range);
        sort($range);

		//Haohang added the judgment of if( $this->_pageCount !=1 ) for meet the reqirement of WangBoYu 
		//that when pageCount=1 show nothing.
		if (1 == $this->_pageCount) {
			return '';
		}

		$html = '<div class="pagination clearfix">';
        //display PRE_PAGE LINK
        if ($this->_pageNo > 1)
        {
            $html .= '<a class="disabled" href="'.$this->genHref($url,$this->_pageNo-1).'">'.self::PAGE_PRE.'</a>';
        }
        else
        {
            $html .= '<span class="disabled">'.self::PAGE_PRE.'</span>';
        }

        $last = 0;
        foreach( $range AS $one )
        {
            if ( $one-$last-1 )
            {
                $html .= '<span>...</span>';
            }
            $last = $one;
            if ( $one != $this->_pageNo )
            {
                $html .= '<a href="'.$this->genHref($url,$one).'">'.$one.'</a>';
            }
            else  if( $this->_pageCount !=1 )
            {
                $html .= '<span class="current">'.$one.'</span>';
            }
        }

        //display NEXT page LINK
        if ( $this->_pageCount != $this->_pageNo )
        {
            $html .= '<a class="disabled" href="'.$this->genHref($url,$this->_pageNo+1).'">'.self::PAGE_NEXT.'</a>';
        }
        else  if( $this->_pageCount !=1 )
        {
            $html .= '<span class="disabled">'.self::PAGE_NEXT.'</span>';
        }
		$html .= '</div>';

        return $html;
    }
}

