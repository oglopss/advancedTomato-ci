#!/usr/bin/env bash

# if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo -e "Starting to update gh-pages\n"

  echo ======== show ~/advancedtomato/release/src-rt/image =======
  ls -l ~/advancedtomato/release/src-rt/image --block-size=K

  #copy data we're interested in to other place
  # mkdir -p $HOME/coverage
  # cp -R $HOME/ss-install/bin/*.tar.gz $HOME/coverage

  #go to home and setup git
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"
  
  echo ===== about to clone ctng-ss-jekyll ===============
  echo 
  x=$[ ( $RANDOM % 25 )  + 10 ]s
  echo sleeping $x
  sleep $x
  
  #using token clone gh-pages branch
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/oglopss/advancedTomato-ci-jekyll.git  gh-pages-$TT_BUILD > /dev/null


  cd gh-pages-$TT_BUILD

  # update ss.yml as well
  echo ======== show $TT_BUILD =======
  echo $TT_BUILD

  # need to regenerate _data/ss.yml
  cd _data

  # datetime=$(date '+%d/%m/%Y %H:%M:%S %Z');

  echo ============= print ss.yml before push changes =============
  cat ./ss.yml

push_changes()
{

  echo ============= print ss.yml before reset hard =============
  cat ./ss.yml

  # git reset --hard
  # git checkout .

  # echo ============= print ss.yml after reset hard =============
  # cat ./ss.yml

  # pull latest before we try something
  # git pull origin gh-pages

  # http://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git
  # LOCAL=$(git rev-parse @)
  # REMOTE=$(git rev-parse @{u})
  # BASE=$(git merge-base @ @{u})

  # if [ $LOCAL = $BASE ]; then
  #     echo "Need to pull"

    # git fetch --all
    # git reset --hard origin/gh-pages

    git reset --hard origin/gh-pages
    git pull

  # fi


  echo ============= print ss.yml in push changes after pull =============
  cat ./ss.yml

    #go into directory and copy data we're interested in to that directory
  cd $HOME/gh-pages-$TT_BUILD
  mkdir -p download && cd download

  # -t makes sure you get the last modified trx, some builds have more than one trx files
  image=~/advancedtomato/release/src-rt/image
  cd $image

  bin=($(ls -1t tomato*.bin))
  chk=($(ls -1t tomato*.chk))
  trx=($(ls -1t tomato*.trx))

  echo =========== image dir ===============
  ls -lt $image/*

  fw=tomato-$TT_BUILD.tar.gz

  if [ "${#bin[@]}" -ge 1 ]; then
    if [ "${#bin[@]}" -eq 1 ]; then
      fw=${bin[0]}
    else
      # echo crap
      tar czvf $fw "${bin[@]}"
      
    fi
  elif [ "${#chk[@]}" -ge 1 ]; then
    if [ "${#chk[@]}" -eq 1 ]; then
      fw=${chk[0]}
    else
      tar czvf $fw "${chk[@]}"
    fi
  elif [ "${#trx[@]}" -ge 1 ]; then
    if [ "${#trx[@]}" -eq 1 ]; then
      fw=${trx[0]}
    else
      tar czvf $fw "${trx[@]}"
    fi
  fi

  cd $HOME/gh-pages-$TT_BUILD/download

  if [ -f $image/$fw ]; then
    cp -Rf $image/$fw .
  else
    echo "$fw not found!"
    fw=""
  fi


  
  # cd $HOME/gh-pages-$TT_BUILD/download

  #add, commit and push files
  git add -f .

  cd ../_data

# if grep -qe ">>>>>>>" ss.yml
# then
# rm -f ss.yml
# fi

echo fw $fw

echo TRAVIS_JOB_NUMBER $TRAVIS_JOB_NUMBER

JOBNUM=$(echo $TRAVIS_JOB_NUMBER | cut -d'.' -f 2)

echo JOBNUM $JOBNUM

JOBNUM=$(printf %04d $JOBNUM)

echo padded JOBNUM $JOBNUM

if grep -qe "build: $TRAVIS_BUILD_NUMBER$" ss.yml
then
    # code if found
    # update files
    if grep -qe "  - $JOBNUM $TT_BUILD $fw$" ss.yml
    then
        echo files already inside skip
    else
        cat >> ss.yml <<EOL
  - $JOBNUM $TT_BUILD $(basename "$fw")
EOL
    fi
  # update datetime
  # sed -ie 's@^date:\s.*@date: '"$datetime"'@g' ss.yml

else
    # code if not found
    echo create new file


    cat > ss.yml <<EOL
build: $TRAVIS_BUILD_NUMBER
files:
  - $JOBNUM $TT_BUILD $(basename "$fw")
EOL

fi

  
  echo ============= print ss.yml after ccat =============
  cat ./ss.yml
  git add -f ss.yml
  
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER $TT_BUILD pushed to gh-pages"
  # git push -fq origin gh-pages # > /dev/null

  # keep retrying until push successful
  # git pull origin gh-pages
  # pushcmd="git push -fq origin gh-pages"
  pushcmd="git push origin gh-pages"
  eval "$pushcmd"

  # cat ../.git/config

}


  push_changes  
  ret=$?
  # echo ========= the value "$ret" ============
  while ! test "$ret" -eq 0
  do
      echo >&2 "push failed with exit status $ret"
      x=$[ ( $RANDOM % 20 )  + 10 ]s
      echo sleeping $x
      sleep $x
      echo wake up!
      # exit 1
      # git pull origin gh-pages
      # eval "$pushcmd"
      push_changes
      ret=$?
  done

  echo -e "Done magic with love\n"
  
# fi
