class WordsController < ApplicationController
  # Création des mots qui n'existe pas
  before_filter :fix_attributes, :only => [ :create, :update ]
  def fix_attributes
    if params[:word] and params[:word][:linked_words_attributes]
      params[:word][:linked_words_attributes].each do |k,v|
        if k['new_']
          w = Word.find_or_create_by_name params[:word][:linked_words_attributes][k][:linked_to_attributes][:name]
          params[:word][:linked_words_attributes][k].delete :linked_to_attributes
          params[:word][:linked_words_attributes][k][:linked_to_id] = w.id
        end
      end
    end
  end
  
  # Switch entre vue admin/anonyme
  def back_office
    session[:user_id] = 1
    redirect_to words_path
  end
  def sign_out
    session[:user_id] = nil
    redirect_to root_path
  end
  
  # autocompletion pour la recherche/mot associé
  autocomplete :word, :name
  
  # GET /words
  # GET /words.json
  def index
    if params[:word] and !params[:word][:name].blank?
      @words = Word.where ["name LIKE :name", { :name => "%#{params[:word][:name]}%"}]
    else
      @words = Word.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @words }
    end
  end

  # GET /words/search
  # GET /words/search.json
  def search
    #filtrage pour la page d'accueil
    @words = Word.all(:order => 'created_at DESC', :limit => 20)
    @title = "Last words"
    
    respond_to do |format|
      format.html { render :action => :index } 
      format.json { render :json => @words }
    end
  end

  def todo
    #filtrage pour les mots à traiter
    @words = Word.todo

    respond_to do |format|
      format.html { render :action => :index } 
      format.json { render :json => @words }
    end
  end

  # GET /words/1
  # GET /words/1.json
  def show
    @word = Word.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @word }
    end
  end

  # GET /words/new
  # GET /words/new.json
  def new
    @word = Word.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @word }
    end
  end

  # GET /words/1/edit
  def edit
    @word = Word.find(params[:id])
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(params[:word])

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, :notice => 'Word was successfully created.' }
        format.json { render :json => @word, :status => :created, :location => @word }
      else
        format.html { render :action => "new" }
        format.json { render :json => @word.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /words/1
  # PUT /words/1.json
  def update
    @word = Word.find(params[:id])

    respond_to do |format|
      if @word.update_attributes(params[:word])
        format.html { redirect_to @word, :notice => 'Word was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @word.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    respond_to do |format|
      format.html { redirect_to words_url }
      format.json { head :ok }
    end
  end
end
