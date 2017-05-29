class TeamsController < ApplicationController

  # GET /teams
  def index
    teams = Team.all
    json_response teams
  end

  # POST /teams
  def create
    team = Team.create! team_params
    json_response(team, :created)
  end

  # GET /teams/:id
  def show
    json_response fetch_team
  end

  # PUT /teams/:id
  def update
    fetch_team.update team_params
    head :no_content
  end

  # DELETE /teams/:id
  def destroy
    fetch_team.destroy
    head :no_content
  end

  private

  def team_params
    # whitelist params
    params.permit(:name, :mission, :vision)
  end

  def fetch_team
    Team.find params[:id]
  end

end
