# Copyright (c) 2021 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

FROM elasticsearch:6.4.1

RUN elasticsearch-plugin install repository-s3 -b

RUN echo -Des.allow_insecure_settings=true >> /usr/share/elasticsearch/config/jvm.options
