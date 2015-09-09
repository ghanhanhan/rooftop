CarrierWave.configure do |config|
    config.fog_credentials = {
        provider:            'AWS',
        aws_access_key_id:   'AKIAIDP4ZATQVNJ75Z5Q',
        aws_secret_access_key: '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',
        region:                'ap-northeast-1'
    }
    config.fog_directory = "soyyy"
end

        