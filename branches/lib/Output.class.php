<?php
class Output {
    const  TYPE_JSON = 'json';
    const TYPE_HTML = 'html';
    /** 
     * output 
     *
     * 输出给异步脚本的响应，支持json和html两种格式
     *
     * @param string    $type       json/html
     * @param int       $code       响应状态，成功为0
     * @param string    $msg        响应信息 
     * @param string    $data       额外传递的数据 
     * @param string    $callback   jsonp请求标识，默认没有 
     * @static
     * @access public
     * @return void
     */
    public static function out($type = self::TYPE_JSON, $code = 0, $msg = "", $data = "", $callback = "") {
        switch ($type) {
            case self::TYPE_JSON:
                self::outputJson($code, $msg, $data, $callback);
                break;
            case self::TYPE_HTML:
                self::outputHtml($code, $msg, $data);
                break;
        }   
    }   
   
            
              /** 
     * outputJson 
     *
     * 以json格式输出
     * 
     * @param int       $code       响应状态，成功为0
     * @param string    $msg        响应信息
     * @param string    $data       额外传递的数据 
     * @param string    $callback   jsonp请求标识，默认没有 
     * @static
     * @access public
     * @return void
     */
    public static function outputJson($code = 0, $msg = "", $data = "", $callback = "") {
        header('Content-Type: text/javascript; charset=utf-8');
        header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
        header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
        header("Cache-Control: no-store, no-cache, must-revalidate");
        header("Cache-Control: post-check=0, pre-check=0", false);
        header("Pragma: no-cache");

        // code field for json output
        $out = array(
            'code' => $code
        );  
        if($code < 0) {
            $out['msg'] = "JsonOut Error: the 'code' parameter should not less than 0.";
            if($callback !== "") {
                echo $callback . "(" . json_encode($out) . ");";
            } else {
                echo json_encode($out);
            }   
            return;
        }   

        // msg field for json output
        if($msg !== "") {
            $out['msg'] = $msg;
        } else if($code > 0 && $msg === "") {
            $out['msg'] = "JsonOut Error: the 'msg' parameter should be defined if the 'code' parameter great than 0.";
            if($callback !== "") {
                echo $callback . "(" . json_encode($out) . ");";
            } else {
                echo json_encode($out);
            }   
            return;
        }

        // data field for json output
        if($data !== "") {
            $out['data'] = $data;
        }

        // jsonp callback with json output
        if($callback !== "") {
            echo $callback . "(" . json_encode($out) . ");";
        } else {
            echo json_encode($out);
        }
    }
    /**
     * outputHtml 
     *
     * 以html方式输出 例如"0;操作成功" "1;操作失败"
     * 
     * @param int       $code       响应状态，成功为0
     * @param string    $msg        响应信息
     * @static
     * @access public
     * @return void
     */
    public static function outputHtml($code = 0, $msg = "", $data = "") {
        if (0 == $code) {
            echo "0;$msg$data";
        } else {
            echo "$code;$msg$data";
        }
    }
}
            