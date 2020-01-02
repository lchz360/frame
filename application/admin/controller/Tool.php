<?php

namespace app\admin\controller;

use think\Config;
use think\Controller;
use think\Request;
use think\response\Json;
use ueditor\Actions;

class Tool extends Controller
{

    /**
     * 上传图片
     * @return Json
     */
    public function uploadImage()
    {
        if (!request()->isAjax()) {
            $this->error('请求方式错误');
        }
        $config = Config::get("LOCAL");
        $fileName = request()->param("filename");
        $file = request()->file($fileName);
        if ($file) {
            $info = $file->move($config['rootPath']);
            if ($info) {
                $realPath = $config['relaPath'] . $info->getSaveName();
                $realPath = str_replace('\\', '/', $realPath);
                $result = array(
                    "status" => 0,
                    "url" => $realPath
                );
                return json($result);
            } else {
                // 上传失败获取错误信息
                $result = array(
                    "error" => $file->getError(),
                );
                return json($result);
            }
        }
        return json_err();
    }

    /**
     * 删除图片
     */
    public function deleteImage()
    {
        if (!request()->isAjax()) {
            $this->error('请求方式错误');
        }
        return json(["status" => 0]);
    }

    /**
     * 富文本编辑框
     * @param Request $request
     * @return false|string
     */
    public function ueditor(Request $request)
    {
        $CONFIG = config('ueditor');
        $action = $request->param('action');

        $actions = new Actions();
        switch ($action) {
            case 'config':
                $result = json_encode($CONFIG);
                break;

            /* 上传图片 */
            case 'uploadimage':
                /* 上传涂鸦 */
            case 'uploadscrawl':
                /* 上传视频 */
            case 'uploadvideo':
                /* 上传文件 */
            case 'uploadfile':
                $result = $actions->upload();
                break;

            /* 列出图片 */
            case 'listimage':
                /* 列出文件 */
            case 'listfile':
                $result = $actions->listFile();
                break;
            /* 抓取远程文件 */
            case 'catchimage':
                $result = $actions->crawler();
                break;

            default:
                $result = json_encode(array(
                    'state' => '请求地址出错'
                ));
                break;
        }

        /* 输出结果 */
        if ($request->has("callback")) {
            $callback = $request->param('callback');
            if (preg_match("/^[\w_]+$/", $callback)) {
                return htmlspecialchars($callback) . '(' . $result . ')';
            } else {
                return json_encode(array(
                    'state' => 'callback参数不合法'
                ));
            }
        } else {
            return $result;
        }
    }

    /**
     * 上传方法
     */
    public function commonUpload()
    {
        if (request()->isPost()) {

            $config = Config::get("LOCAL");

            $file = request()->file("upfile");
            if ($file) {
                if (strtolower($file->getExtension()) == 'mp3') {
                    $rootPath = $config['rootAudio'];
                    $relaPath = $config['relaAudio'];
                } else {
                    $rootPath = $config['rootPath'];
                    $relaPath = $config['relaPath'];
                }
                $info = $file->move($rootPath);
                if ($info) {
                    $realPath = $relaPath . $info->getSaveName();
                    $result = array(
                        "state" => "SUCCESS",
                        "url" => $realPath
                    );
                    return json_encode($result);
                } else {
                    // 上传失败获取错误信息
                    echo $file->getError();
                }
            }

            die;
        }
    }
}