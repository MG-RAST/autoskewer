


default: data/vectors-P5.1.bt2 data/vectors-P7.1.bt2

%.1.bt2: %.fa
	$(eval STEM=$(subst .1.bt2,,$@))
	bowtie2-build $^ $(STEM)

