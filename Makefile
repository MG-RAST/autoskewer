
indexes: data/vectors-P5.1.bt2 data/vectors-P7.1.bt2

install: indexes
	python setup.py install

clean:
	rm -fv *.scrubbed.*
	rm -fv example/*.scrubbed.*

%.1.bt2: %.fa
	$(eval STEM=$(subst .1.bt2,,$@))
	bowtie2-build $^ $(STEM)

