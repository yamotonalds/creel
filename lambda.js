'use strict';

const AWS = require('aws-sdk');

console.log('Loading function');

exports.handler = (event, context, callback) => {
    // Log the received event
    console.log('Received event: ', event);
    // Get parameters for the SubmitJob call from event
    // http://docs.aws.amazon.com/batch/latest/APIReference/API_SubmitJob.html
    const params = {
        jobDefinition: 'creel:3',
        jobName: 'creel',
        jobQueue: 'creel',
        containerOverrides: null,
        parameters: { 'input_file': event.Records[0].s3.bucket.name + '/' + event.Records[0].s3.object.key },
    };
    // Submit the Batch Job
    new AWS.Batch().submitJob(params, (err, data) => {
        if (err) {
            console.error(err);
            const message = `Error calling SubmitJob for: ${event.jobName}`;
            console.error(message);
            callback(message);
        } else {
            const jobId = data.jobId;
            console.log('jobId:', jobId);
            callback(null, jobId);
        }
    });
};
