'use strict';
const QuanMiaoLightApp20240801 = require('@alicloud/quanmiaolightapp20240801');
const OpenApi = require('@alicloud/openapi-client');
const Util = require('@alicloud/tea-util');
const Tea = require('@alicloud/tea-typescript');
const DEFAULT_COMMENTS = require('./config/defaultComments');

class CommentClient {
  static createClient() {
    let config = new OpenApi.Config({
      accessKeyId: process.env['ALIBABA_CLOUD_ACCESS_KEY_ID'],
      accessKeySecret: process.env['ALIBABA_CLOUD_ACCESS_KEY_SECRET'],
      type: 'string',
      bodyType: 'string'
    });
    config.endpoint = `quanmiaolightapp.cn-beijing.aliyuncs.com`;
    return new QuanMiaoLightApp20240801.default(config);
  }

  static async generateComments(content, style) {
    console.log('Generating comments for:', { content, style });
    
    try {
      let client = CommentClient.createClient();
      let runCommentGenerationRequest = new QuanMiaoLightApp20240801.RunCommentGenerationRequest({
        sourceMaterial: content,
        style: style,
        length: '10',
        numComments: '10'
      });
      
      let runtime = new Util.RuntimeOptions({
        readTimeout: 10000,
        connectTimeout: 5000
      });
      
      let headers = { };

      let resp = await client.runCommentGenerationWithOptions(
        'llm-1nhq29y7ubb62oyl',
        runCommentGenerationRequest,
        headers,
        runtime
      );

      if (!resp || !resp.body) {
        console.log('Empty response, returning default comments');
        return DEFAULT_COMMENTS;
      }

      return resp.body;
      
    } catch (error) {
      console.error('Error in generateComments:', error);
      console.log('Returning default comments due to error');
      return DEFAULT_COMMENTS;
    }
  }
}

module.exports = CommentClient;