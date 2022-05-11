FROM python:3.10.0

ARG FVTT_OPTIMIZER_VERSION=0.1.3

RUN curl -L https://github.com/watermelonwolverine/fvttoptimizer/releases/download/$FVTT_OPTIMIZER_VERSION/fvttoptimizer --output usr/bin/fvttoptimizer
RUN chmod +x usr/bin/fvttoptimizer
RUN echo '{"absolute_path_to_foundry_data":"/app/Data"}' > /etc/fvttoptimizer.conf

CMD ["fvttoptimizer"]
