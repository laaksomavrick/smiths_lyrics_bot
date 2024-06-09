FROM public.ecr.aws/lambda/ruby:3.2

# Need in order to build json gem
# TODO: need to investigate if this is redundant
RUN yum install -y gcc gcc-c++ make

ENV GEM_HOME=${LAMBDA_TASK_ROOT}

COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle install --without dev test

COPY smiths_lyrics_bot smiths_lyrics_bot
CMD ["smiths_lyrics_bot/app.lambda_handler"]