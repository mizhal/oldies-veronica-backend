#tabla feeds

def table_feeds(vero):
  cur = vero.cursor()
  cur.execute('''create sequence feed_seq''')
  cur.execute('''CREATE TABLE feeds
    (
      id bigint NOT NULL DEFAULT nextval('feed_seq'::regclass),
      title text,
      rss text NOT NULL,
      site text,
      freq real DEFAULT 1, -- frecuencia en posts por dia
      last_read timestamp without time zone NOT NULL DEFAULT now(),
      created timestamp without time zone NOT NULL DEFAULT now(),
      CONSTRAINT feeds_pkey PRIMARY KEY (id),
      CONSTRAINT feeds_rss_key UNIQUE (rss)
    )''')
  vero.commit()
